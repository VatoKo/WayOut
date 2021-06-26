//  
//  OrganizationHomeRouter.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation

protocol OrganizationHomeRouter {
    
}

class OrganizationHomeRouterImpl: OrganizationHomeRouter {
    
    private weak var controller: OrganizationHomeController?
    
    init(_ controller: OrganizationHomeController?) {
        self.controller = controller
    }
    
}
