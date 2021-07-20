//  
//  OrganizationChooserConfigurator.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 12.06.21.
//

import Foundation
import Core

protocol OrganizationChooserConfigurator {
    func configure(_ controller: OrganizationChooserController, user: User)
}

class OrganizationChooserConfiguratorImpl: OrganizationChooserConfigurator {
    
    func configure(_ controller: OrganizationChooserController, user: User) {
        let router: OrganizationChooserRouter = OrganizationChooserRouterImpl(controller)
        
        let presenter: OrganizationChooserPresenter = OrganizationChooserPresenterImpl(
            view: controller,
            router: router,
            user: user
        )
        
        controller.presenter = presenter
    }
    
}
