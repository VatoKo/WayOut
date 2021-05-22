//  
//  UserHomeRouter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 13.05.21.
//

import Foundation

protocol UserHomeRouter {
    
}

class UserHomeRouterImpl: UserHomeRouter {
    
    private weak var controller: UserHomeController?
    
    init(_ controller: UserHomeController?) {
        self.controller = controller
    }
    
}
