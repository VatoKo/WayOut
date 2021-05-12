//  
//  SignUpUserRouter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import Foundation

protocol SignUpUserRouter {
    
}

class SignUpUserRouterImpl: SignUpUserRouter {
    
    private weak var controller: SignUpUserController?
    
    init(_ controller: SignUpUserController?) {
        self.controller = controller
    }
    
}
