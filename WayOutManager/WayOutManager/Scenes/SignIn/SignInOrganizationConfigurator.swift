//  
//  SignInOrganizationConfigurator.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation

protocol SignInOrganizationConfigurator {
    func configure(_ controller: SignInOrganizationController)
}

class SignInOrganizationConfiguratorImpl: SignInOrganizationConfigurator {
    
    func configure(_ controller: SignInOrganizationController) {
        let router: SignInOrganizationRouter = SignInOrganizationRouterImpl(controller)
        
        let presenter: SignInOrganizationPresenter = SignInOrganizationPresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
