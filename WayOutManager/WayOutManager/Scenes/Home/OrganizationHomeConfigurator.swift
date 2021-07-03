//  
//  OrganizationHomeConfigurator.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation
import Core

protocol OrganizationHomeConfigurator {
    func configure(_ controller: OrganizationHomeController, organization: Organization, members: [User])
}

class OrganizationHomeConfiguratorImpl: OrganizationHomeConfigurator {
    
    func configure(_ controller: OrganizationHomeController, organization: Organization, members: [User]) {
        let router: OrganizationHomeRouter = OrganizationHomeRouterImpl(controller)
        
        let presenter: OrganizationHomePresenter = OrganizationHomePresenterImpl(
            view: controller,
            router: router,
            organization: organization,
            members: members
        )
        
        controller.presenter = presenter
    }
    
}
