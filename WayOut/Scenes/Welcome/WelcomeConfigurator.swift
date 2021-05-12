//  
//  WelcomeConfigurator.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import Foundation

protocol WelcomeConfigurator {
    func configure(_ controller: WelcomeController)
}

class WelcomeConfiguratorImpl: WelcomeConfigurator {
    
    func configure(_ controller: WelcomeController) {
        let router: WelcomeRouter = WelcomeRouterImpl(controller)
        
        let presenter: WelcomePresenter = WelcomePresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
