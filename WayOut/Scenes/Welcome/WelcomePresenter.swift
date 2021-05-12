//  
//  WelcomePresenter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import Foundation

protocol WelcomeView: AnyObject {
    
}

protocol WelcomePresenter {
    func didTapOrganization()
    func didTapUser()
}

class WelcomePresenterImpl: WelcomePresenter {
    
    private weak var view: WelcomeView?
    private var router: WelcomeRouter
    
    init(view: WelcomeView, router: WelcomeRouter) {
        self.view = view
        self.router = router
    }
    
    func didTapOrganization() {
        print("did tap organization")
    }
    
    func didTapUser() {
        router.navigateToUserLogin()
    }
}
