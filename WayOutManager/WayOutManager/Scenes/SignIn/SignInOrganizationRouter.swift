//  
//  SignInOrganizationRouter.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation

protocol SignInOrganizationRouter {
    func navigateToHome()
    func nagigateToSignUp()
}

class SignInOrganizationRouterImpl: SignInOrganizationRouter {
    
    private weak var controller: SignInOrganizationController?
    
    init(_ controller: SignInOrganizationController?) {
        self.controller = controller
    }
    
    func navigateToHome() {
        let vc = OrganizationHomeController.configured()
        controller?.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func nagigateToSignUp() {
        let vc = SignUpOrganizationController.configured()
        vc.modalPresentationStyle = .fullScreen
        controller?.present(vc, animated: true, completion: nil)
    }
    
}
