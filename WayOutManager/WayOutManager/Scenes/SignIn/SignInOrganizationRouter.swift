//  
//  SignInOrganizationRouter.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation
import Core

protocol SignInOrganizationRouter {
    func navigateToHome(of organization: Organization, with members: [User])
    func nagigateToSignUp()
}

class SignInOrganizationRouterImpl: SignInOrganizationRouter {
    
    private weak var controller: SignInOrganizationController?
    
    init(_ controller: SignInOrganizationController?) {
        self.controller = controller
    }
    
    func navigateToHome(of organization: Organization, with members: [User]) {
        let vc = OrganizationHomeController.configured(organization: organization, members: members)
        controller?.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func nagigateToSignUp() {
        let vc = SignUpOrganizationController.configured()
        vc.modalPresentationStyle = .fullScreen
        controller?.present(vc, animated: true, completion: nil)
    }
    
}
