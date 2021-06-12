//  
//  OrganizationChooserConfigurator.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 12.06.21.
//

import Foundation

protocol OrganizationChooserConfigurator {
    func configure(_ controller: OrganizationChooserController)
}

class OrganizationChooserConfiguratorImpl: OrganizationChooserConfigurator {
    
    func configure(_ controller: OrganizationChooserController) {
        let router: OrganizationChooserRouter = OrganizationChooserRouterImpl(controller)
        
        let presenter: OrganizationChooserPresenter = OrganizationChooserPresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
