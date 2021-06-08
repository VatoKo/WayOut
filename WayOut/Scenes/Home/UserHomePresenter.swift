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
    func showImageSourceSelectionSheet(didSelectCamera: @escaping () -> Void, didSelectGallery: @escaping () -> Void)
    func showBanner(title: String?, subtitle: String, style: BannerStyle)
}

protocol UserHomePresenter {
    var tableDataSource: [CellModel] { get set }
    func didTapScan()
    func didSelectFromGallery(photo: UIImage?)
}

class UserHomePresenterImpl: UserHomePresenter {
    
    lazy var tableDataSource: [CellModel] = [
        GreetingCellModel(greetingText: "Hello, \(user.name)!"),
        PersonalInfoCellModel(
            name: "\(user.name) \(user.surname)",
            numberPlate: user.numberPlate,
            phoneNumber: user.phoneNumber,
            email: user.email
        ),
        TitleCellModel(title: "Your organization"),
        JoinOrganizationCellModel()
    ]
    
    private let user: User
    private let plateRecognizer: PlateRecognizer
    private let plateFinder: PlateFinder
    
    private weak var view: UserHomeView!
    private var router: UserHomeRouter
    
    init(
        view: UserHomeView,
        router: UserHomeRouter,
        user: User,
        plateRecognizer: PlateRecognizer,
        plateFinder: PlateFinder
    ) {
        self.view = view
        self.router = router
        self.user = user
        self.plateRecognizer = plateRecognizer
        self.plateFinder = plateFinder
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


