//  
//  PlateScannerConfigurator.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 02.06.21.
//

import Foundation

protocol PlateScannerConfigurator {
    func configure(_ controller: PlateScannerController)
}

class PlateScannerConfiguratorImpl: PlateScannerConfigurator {
    
    func configure(_ controller: PlateScannerController) {
        let router: PlateScannerRouter = PlateScannerRouterImpl(controller)
        
        let presenter: PlateScannerPresenter = PlateScannerPresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
