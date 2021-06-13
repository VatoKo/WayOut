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
        router.nagigateToSignUp()
    }
    
    func didTapSignIn() {
        view.isLoading = true
        Authentication.shared.signIn(user: SignInUserData(email: view.email, password: view.password)) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    let isOrganizationMember = user.organizationId != nil
                    if isOrganizationMember {
                        OrganizationManager.shared.fetchAllOrganizations { [weak self] result in
                            DispatchQueue.main.async {
                                guard let self = self else { return }
                                self.view.isLoading = false
                                switch result {
                                case .success(let organizations):
                                    if let organization = organizations.first(where: { $0.id == user.organizationId }) {
                                        self.router.navigateToHome(of: user, with: organization)
                                    }
                                case .failure(let error):
                                    self.view.showBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
                                }
                            }
                        }
                    } else {
                        self.view.isLoading = false
                        self.router.navigateToHome(of: user, with: nil)
                    }
                case .failure(let error):
                    self.view.isLoading = false
                    self.view.shakeFields()
                    self.view.showBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
                }
            }
        }
    }
}
