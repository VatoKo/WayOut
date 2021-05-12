//  
//  SignInUserConfigurator.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import Foundation

protocol SignInUserConfigurator {
    func configure(_ controller: SignInUserController)
}

class SignInUserConfiguratorImpl: SignInUserConfigurator {
    
    func configure(_ controller: SignInUserController) {
        let router: SignInUserRouter = SignInUserRouterImpl(controller)
        
        let presenter: SignInUserPresenter = SignInUserPresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
