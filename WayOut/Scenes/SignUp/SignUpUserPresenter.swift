//  
//  SignUpUserPresenter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import Foundation

protocol SignUpUserView: AnyObject {
    
}

protocol SignUpUserPresenter {
    
}

class SignUpUserPresenterImpl: SignUpUserPresenter {
    
    private weak var view: SignUpUserView?
    private var router: SignUpUserRouter
    
    init(view: SignUpUserView, router: SignUpUserRouter) {
        self.view = view
        self.router = router
    }
}
