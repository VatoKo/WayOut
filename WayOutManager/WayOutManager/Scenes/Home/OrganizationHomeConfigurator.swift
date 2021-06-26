//  
//  OrganizationHomeConfigurator.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation

protocol OrganizationHomeConfigurator {
    func configure(_ controller: OrganizationHomeController)
}

class OrganizationHomeConfiguratorImpl: OrganizationHomeConfigurator {
    
    func configure(_ controller: OrganizationHomeController) {
        let router: OrganizationHomeRouter = OrganizationHomeRouterImpl(controller)
        
        let presenter: OrganizationHomePresenter = OrganizationHomePresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
