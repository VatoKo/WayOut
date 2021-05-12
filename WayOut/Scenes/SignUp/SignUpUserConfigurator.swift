//  
//  SignUpUserConfigurator.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import Foundation

protocol SignUpUserConfigurator {
    func configure(_ controller: SignUpUserController)
}

class SignUpUserConfiguratorImpl: SignUpUserConfigurator {
    
    func configure(_ controller: SignUpUserController) {
        let router: SignUpUserRouter = SignUpUserRouterImpl(controller)
        
        let presenter: SignUpUserPresenter = SignUpUserPresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
