//  
//  SignInOrganizationPresenter.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation

protocol SignInOrganizationView: AnyObject {
    
}

protocol SignInOrganizationPresenter {
    func didTapSignUp()
    func didTapSignIn()
}

class SignInOrganizationPresenterImpl: SignInOrganizationPresenter {
    
    private weak var view: SignInOrganizationView?
    private var router: SignInOrganizationRouter
    
    init(view: SignInOrganizationView, router: SignInOrganizationRouter) {
        self.view = view
        self.router = router
    }
    
    
    func didTapSignUp() {
        router.nagigateToSignUp()
    }
    
    func didTapSignIn() {
        router.navigateToHome()
    }
    
}
