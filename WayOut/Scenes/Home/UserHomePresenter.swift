//  
//  UserHomePresenter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 13.05.21.
//

import UIKit
import Core

protocol UserHomeView: AnyObject {
    func showImageSourceSelectionSheet(didSelectCamera: @escaping () -> Void, didSelectGallery: @escaping () -> Void)
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
    
    private weak var view: UserHomeView!
    private var router: UserHomeRouter
    
    init(
        view: UserHomeView,
        router: UserHomeRouter,
        user: User
    ) {
        self.view = view
        self.router = router
        self.user = user
    }
    
    func didTapScan() {
        view.showImageSourceSelectionSheet(didSelectCamera: handleScannerCameraSelection, didSelectGallery: router.openGallery)
    }
    
    private func handleScannerCameraSelection() {
        router.openPlateScanner(delegate: self)
    }
    
}

extension UserHomePresenterImpl: PlateScannerControllerDelegate {
    
    func plateScannerController(_ sender: PlateScannerController, didCapture photo: UIImage?) {
        print(photo)
    }
    
    func didSelectFromGallery(photo: UIImage?) {
        print(photo)
    }
    
}


