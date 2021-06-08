//  
//  UserHomeConfigurator.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 13.05.21.
//

import Foundation
import Core

protocol UserHomeConfigurator {
    func configure(_ controller: UserHomeController, user: User)
}

class UserHomeConfiguratorImpl: UserHomeConfigurator {
    
    func configure(_ controller: UserHomeController, user: User) {
        let router: UserHomeRouter = UserHomeRouterImpl(controller)
        
        let plateRecognizer: PlateRecognizer = PlateRecognizerImpl()
        let plateFinder: PlateFinder = PlateFinderImpl.shared
        
        let presenter: UserHomePresenter = UserHomePresenterImpl(
            view: controller,
            router: router,
            user: user,
            plateRecognizer: plateRecognizer,
            plateFinder: plateFinder
        )
        
        controller.presenter = presenter
    }
    
}
