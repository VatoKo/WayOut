//  
//  UserHomeRouter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 13.05.21.
//

import UIKit
import Core
import MobileCoreServices

protocol UserHomeRouter {
    func openPlateScanner(delegate: PlateScannerControllerDelegate)
    func openGallery()
    func showInfoDialog(with model: InfoDialogModel)
    func openWelcomePage()
    func openOrganizationChooser(user: User)
}

class UserHomeRouterImpl: UserHomeRouter {
    
    private weak var controller: UserHomeController?
    
    init(_ controller: UserHomeController?) {
        self.controller = controller
    }
    
    
    func openPlateScanner(delegate: PlateScannerControllerDelegate) {
        let vc = PlateScannerController.configured()
        vc.delegate = delegate
        vc.modalPresentationStyle = .fullScreen
        controller?.present(vc, animated: true, completion: nil)
    }
    
    func openGallery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = controller
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        controller?.present(imagePickerController, animated: true, completion: nil)
    }
    
    func showInfoDialog(with model: InfoDialogModel) {
        let dialog = InfoDialog.configured(with: model)
        controller?.present(dialog, animated: false, completion: nil)
    }
    
    func openWelcomePage() {
        let vc = WelcomeController.configured()
        controller?.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func openOrganizationChooser(user: User) {
        let vc = OrganizationChooserController.configured(user: user)
        vc.modalPresentationStyle = .fullScreen
        controller?.present(vc, animated: true, completion: nil)
    }
    
}
