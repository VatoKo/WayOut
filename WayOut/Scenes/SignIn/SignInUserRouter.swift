//  
//  SignInUserRouter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import Foundation
import Core

protocol SignInUserRouter {
    func navigateToHome(of user: User, with organization: Organization?)
    func nagigateToSignUp()
}

class SignInUserRouterImpl: SignInUserRouter {
    
    private weak var controller: SignInUserController?
    
    init(_ controller: SignInUserController?) {
        self.controller = controller
    }
    
    func navigateToHome(of user: User, with organization: Organization?) {
        let vc = UserHomeController.configured(with: user, organization: organization)
        controller?.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func nagigateToSignUp() {
        let vc = SignUpUserController.configured()
        vc.modalPresentationStyle = .fullScreen
        controller?.present(vc, animated: true, completion: nil)
    }
    
}
