//  
//  PlateScannerRouter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 02.06.21.
//

import Foundation

protocol PlateScannerRouter {
    
}

class PlateScannerRouterImpl: PlateScannerRouter {
    
    private weak var controller: PlateScannerController?
    
    init(_ controller: PlateScannerController?) {
        self.controller = controller
    }
    
}
