//  
//  WelcomeRouter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import Foundation
import WayOutManager

protocol WelcomeRouter {
    func navigateToUserLogin()
    func navigateToOrganizationLogin()
}

class WelcomeRouterImpl: WelcomeRouter {
    
    private weak var controller: WelcomeController?
    
    init(_ controller: WelcomeController?) {
        self.controller = controller
    }
    
    func navigateToUserLogin() {
        let vc = SignInUserController.configured()
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToOrganizationLogin() {
        let vc = SignInOrganizationController.configured()
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
