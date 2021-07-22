//  
//  MembershipRequestConfigurator.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 20.07.21.
//

import Foundation
import Core

protocol MembershipRequestConfigurator {
    func configure(_ controller: MembershipRequestController, organization: Organization)
}

class MembershipRequestConfiguratorImpl: MembershipRequestConfigurator {
    
    func configure(_ controller: MembershipRequestController, organization: Organization) {
        let router: MembershipRequestRouter = MembershipRequestRouterImpl(controller)
        
        let presenter: MembershipRequestPresenter = MembershipRequestPresenterImpl(
            view: controller,
            router: router,
            organization: organization
        )
        
        controller.presenter = presenter
    }
    
}
