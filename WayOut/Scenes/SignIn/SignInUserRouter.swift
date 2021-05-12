//  
//  SignInUserRouter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import Foundation

protocol SignInUserRouter {
    
}

class SignInUserRouterImpl: SignInUserRouter {
    
    private weak var controller: SignInUserController?
    
    init(_ controller: SignInUserController?) {
        self.controller = controller
    }
    
}
