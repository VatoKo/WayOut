//  
//  SignUpOrganizationConfigurator.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation

protocol SignUpOrganizationConfigurator {
    func configure(_ controller: SignUpOrganizationController)
}

class SignUpOrganizationConfiguratorImpl: SignUpOrganizationConfigurator {
    
    func configure(_ controller: SignUpOrganizationController) {
        let router: SignUpOrganizationRouter = SignUpOrganizationRouterImpl(controller)
        
        let presenter: SignUpOrganizationPresenter = SignUpOrganizationPresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
