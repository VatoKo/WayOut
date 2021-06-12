//  
//  OrganizationChooserRouter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 12.06.21.
//

import Foundation

protocol OrganizationChooserRouter {
    
}

class OrganizationChooserRouterImpl: OrganizationChooserRouter {
    
    private weak var controller: OrganizationChooserController?
    
    init(_ controller: OrganizationChooserController?) {
        self.controller = controller
    }
    
}
