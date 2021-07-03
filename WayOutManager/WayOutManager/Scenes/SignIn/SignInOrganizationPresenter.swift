//  
//  SignInOrganizationPresenter.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation
import Core
import NotificationBannerSwift

protocol SignInOrganizationView: AnyObject {
    var email: String { get set }
    var password: String { get set }
    var isLoading: Bool { get set }
    func shakeFields()
    func showBanner(title: String?, subtitle: String, style: BannerStyle)
}

protocol SignInOrganizationPresenter {
    func didTapSignUp()
    func didTapSignIn()
}

class SignInOrganizationPresenterImpl: SignInOrganizationPresenter {
    
    private weak var view: SignInOrganizationView!
    private var router: SignInOrganizationRouter
    
    init(view: SignInOrganizationView, router: SignInOrganizationRouter) {
        self.view = view
        self.router = router
    }
    
    
    func didTapSignUp() {
        router.nagigateToSignUp()
    }
    
    func didTapSignIn() {
        view.isLoading = true
        Authentication.shared.signIn(organization: SignInOrganizationData(email: view.email, password: view.password)) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let organization):
                    print(organization)
                    DatabaseManager.shared.fetchAllUsers { [weak self] result in
                        guard let self = self else { return }
                        DispatchQueue.main.async {
                            self.view.isLoading = false
                            switch result {
                            case .success(let users):
                                let organizationMembers = users.filter { $0.organizationId == organization.id }
                                self.router.navigateToHome(of: organization, with: organizationMembers)
                            case .failure(let error):
                                self.view.showBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
                            }
                        }
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
