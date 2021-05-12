//  
//  SignInUserPresenter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import Foundation
import Core
import NotificationBannerSwift

protocol SignInUserView: AnyObject {
    var email: String { get set }
    var password: String { get set }
    var isLoading: Bool { get set }
    func shakeFields()
    func showBanner(title: String?, subtitle: String, style: BannerStyle)
}

protocol SignInUserPresenter {
    func didTapSignUp()
    func didTapSignIn()
}

class SignInUserPresenterImpl: SignInUserPresenter {
    
    private weak var view: SignInUserView!
    private var router: SignInUserRouter
    
    init(view: SignInUserView, router: SignInUserRouter) {
        self.view = view
        self.router = router
    }
    
    func didTapSignUp() {
        print("Did tap sign up")
    }
    
    func didTapSignIn() {
        print("Did tap sign in")
        view.isLoading = true
        Authentication.shared.signIn(user: SignInUserData(email: view.email, password: view.password)) { (result) in
            DispatchQueue.main.async {
                self.view.isLoading = false
                switch result {
                case .success(let user):
                    self.view.showBanner(title: "\(user.name) \(user.surname)", subtitle: user.numberPlate, style: .success)
                case .failure(let error):
                    self.view.shakeFields()
                    self.view.showBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
                }
            }
        }
    }
}
