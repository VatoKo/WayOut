//  
//  SignInUserRouter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import Foundation
import Core

protocol SignInUserRouter {
    func navigateToHome(of user: User)
}

class SignInUserRouterImpl: SignInUserRouter {
    
    private weak var controller: SignInUserController?
    
    init(_ controller: SignInUserController?) {
        self.controller = controller
    }
    
    func navigateToHome(of user: User) {
        let vc = UserHomeController.configured(with: user)
        controller?.navigationController?.setViewControllers([vc], animated: true)
    }
    
}
