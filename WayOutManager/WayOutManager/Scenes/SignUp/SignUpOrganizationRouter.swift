//  
//  SignUpOrganizationRouter.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation

protocol SignUpOrganizationRouter {
    
}

class SignUpOrganizationRouterImpl: SignUpOrganizationRouter {
    
    private weak var controller: SignUpOrganizationController?
    
    init(_ controller: SignUpOrganizationController?) {
        self.controller = controller
    }
    
}
