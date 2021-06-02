//  
//  PlateScannerPresenter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 02.06.21.
//

import Foundation

protocol PlateScannerView: AnyObject {
    
}

protocol PlateScannerPresenter {
    
}

class PlateScannerPresenterImpl: PlateScannerPresenter {
    
    private weak var view: PlateScannerView?
    private var router: PlateScannerRouter
    
    init(view: PlateScannerView, router: PlateScannerRouter) {
        self.view = view
        self.router = router
    }
}
