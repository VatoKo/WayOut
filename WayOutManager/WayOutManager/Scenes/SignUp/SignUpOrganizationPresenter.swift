//  
//  SignUpOrganizationPresenter.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation
import Core
import NotificationBannerSwift

protocol SignUpOrganizationView: AnyObject {
    var name: String { get set }
    var email: String { get set }
    var password: String { get set }
    var repeatPassword: String { get set }
    func showBanner(title: String?, subtitle: String, style: BannerStyle)
    func closeController()
}

protocol SignUpOrganizationPresenter {
    func didTapCreateAccount()
}

class SignUpOrganizationPresenterImpl: SignUpOrganizationPresenter {
    
    private weak var view: SignUpOrganizationView?
    private var router: SignUpOrganizationRouter
    
    private static let PasswordValidationRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    private static let EmailValidationRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    init(view: SignUpOrganizationView, router: SignUpOrganizationRouter) {
        self.view = view
        self.router = router
    }
    
    func didTapCreateAccount() {
        guard let view = view else { return }
        guard isDataValidated else { return }
        Authentication.shared.signUp(
            organization: .init(
                email: view.email,
                password: view.password,
                name: view.name
            )
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let organization):
                    print(organization)
                    view.showBanner(title: "Success", subtitle: "Organization created successfully", style: .success)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        view.closeController()
                    }
                case .failure(let error):
                    view.showBanner(title: "Organization account creation failed", subtitle: error.localizedDescription, style: .danger)
                }
            }
        }
    }
    
}

extension SignUpOrganizationPresenterImpl {
    
    private var isDataValidated: Bool {
        guard let view = view else { return false }
        let fields = [
            view.name,
            view.email,
            view.password,
            view.repeatPassword
        ]
        if !fields.allSatisfy({ !$0.isEmpty }) {
            view.showBanner(title: nil, subtitle: "Please fill all the fields to continue", style: .warning)
            return false
        }
        
        if view.password != view.repeatPassword {
            view.showBanner(title: nil, subtitle: "Entered passwords do not match", style: .warning)
            return false
        }
        
        if !view.password.matches(SignUpOrganizationPresenterImpl.PasswordValidationRegex) {
            view.showBanner(title: nil, subtitle: "The password does not satisfy requirements", style: .warning)
            return false
        }
        
        if !view.email.matches(SignUpOrganizationPresenterImpl.EmailValidationRegex) {
            view.showBanner(title: nil, subtitle: "The email is not in valid format", style: .warning)
            return false
        }
        
        return true
    }
    
}
