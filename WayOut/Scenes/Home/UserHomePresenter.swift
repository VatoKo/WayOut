//  
//  UserHomePresenter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 13.05.21.
//

import UIKit
import Core
import NotificationBannerSwift

protocol UserHomeView: AnyObject {
    var scanButtonIsEnabled: Bool { get set }
    func showImageSourceSelectionSheet(didSelectCamera: @escaping () -> Void, didSelectGallery: @escaping () -> Void)
    func showBanner(title: String?, subtitle: String, style: BannerStyle)
    func reloadList()
}

protocol UserHomePresenter {
    var tableDataSource: [CellModel] { get }
    func viewDidLoad()
    func didTapScan()
    func didSelectFromGallery(photo: UIImage?)
}

class UserHomePresenterImpl: UserHomePresenter {
        
    var tableDataSource: [CellModel] {
        return [
            GreetingCellModel(greetingText: "Hello, \(user.name)!", didTapLogout: handleLogout),
            PersonalInfoCellModel(
                name: "\(user.name) \(user.surname)",
                numberPlate: user.numberPlate,
                phoneNumber: user.phoneNumber,
                email: user.email
            ),
            TitleCellModel(title: "Your organization"),
            organizationCellModel
        ]
    }
    
    private let user: User
    private let organization: Organization?
    private let plateRecognizer: PlateRecognizer
    private let plateFinder: PlateFinder
    private var membershipRequestIsSent = false
    
    private weak var view: UserHomeView!
    private var router: UserHomeRouter
    
    init(
        view: UserHomeView,
        router: UserHomeRouter,
        user: User,
        organization: Organization?,
        plateRecognizer: PlateRecognizer,
        plateFinder: PlateFinder
    ) {
        self.view = view
        self.router = router
        self.user = user
        self.organization = organization
        self.plateRecognizer = plateRecognizer
        self.plateFinder = plateFinder
    }
    
    func viewDidLoad() {
        let isOrganizationMember = user.organizationId != nil
        view.scanButtonIsEnabled = isOrganizationMember
        NotificationCenter.default.addObserver(self, selector: #selector(handleMembershipRequestSent), name: .init("MEMBERSHIP_REQUEST_DID_SEND"), object: nil)
    }
    
    func didTapScan() {
        view.showImageSourceSelectionSheet(didSelectCamera: handleScannerCameraSelection, didSelectGallery: router.openGallery)
    }
    
    private func handleScannerCameraSelection() {
        router.openPlateScanner(delegate: self)
    }
    
    private func recognizeNumberPlate(on photo: UIImage) {
        plateRecognizer.recognizePlateNumber(on: photo) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let recognizedData):
                    self.handleRecognizedPlate(data: recognizedData)
                case .failure(let error):
                    self.view.showBanner(title: "Recognition Failed", subtitle: error.localizedDescription, style: .danger)
                }
            }
        }
    }
    
    private func handleRecognizedPlate(data: PlateRecognitionData) {
        self.plateFinder.findUser(with: data.recognizedNumberPlate, in: self.user.organizationId ?? "123") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let foundUser):
                    self.router.showInfoDialog(
                        with: InfoDialogModel(
                            plateImage: data.rectangeBoundedImage,
                            numberPlate: data.recognizedNumberPlate,
                            name: "\(foundUser.name) \(foundUser.surname)",
                            phoneNumber: foundUser.phoneNumber,
                            email: foundUser.email
                        )
                    )
                case .failure(let error):
                    if let error = error as? PlateFinderError {
                        self.view.showBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
                    }
                }
            }
        }
    }
    
    private func handleLogout() {
        Authentication.shared.logout { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success:
                    self.router.openWelcomePage()
                case .failure(let error):
                    self.view.showBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
                }
            }
        }
    }
    
    private func handleJoinOrganization() {
        router.openOrganizationChooser(user: user)
    }
    
}

extension UserHomePresenterImpl: PlateScannerControllerDelegate {
    
    func plateScannerController(_ sender: PlateScannerController, didCapture photo: UIImage?) {
        guard let photo = photo else {
            print("No image")
            return
        }
        recognizeNumberPlate(on: photo)
    }
    
    func didSelectFromGallery(photo: UIImage?) {
        guard let photo = photo else {
            print("No image")
            return
        }
        recognizeNumberPlate(on: photo)
    }
    
}

extension UserHomePresenterImpl {
    
    @objc
    private func handleMembershipRequestSent() {
        membershipRequestIsSent = true
        view.reloadList()
    }
    
}


extension UserHomePresenterImpl  {
    
    var organizationCellModel: CellModel {
        if membershipRequestIsSent {
            return PendingRequestCellModel()
        } else {
            return user.organizationId == nil
                ? JoinOrganizationCellModel(didTapJoinOrganization: handleJoinOrganization)
                : MyOrganizationCellModel(
                    organizationId: organization!.id,
                    organizationName: organization!.name,
                    organizationEmail: organization!.email,
                    numberOfMembers: "100"
                )
        }
    }
    
}

