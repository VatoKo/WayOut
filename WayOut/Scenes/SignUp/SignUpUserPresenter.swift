//  
//  SignUpUserPresenter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import Foundation
import Core
import NotificationBannerSwift

protocol SignUpUserView: AnyObject {
    var name: String { get set }
    var surname: String { get set }
    var phoneNumber: String { get set }
    var numberPlate: String { get set }
    var email: String { get set }
    var password: String { get set }
    var repeatPassword: String { get set }
    func showBanner(title: String?, subtitle: String, style: BannerStyle)
    func closeController()
}

protocol SignUpUserPresenter {
    func didTapCreateAccount()
}

class SignUpUserPresenterImpl: SignUpUserPresenter {
    
    private weak var view: SignUpUserView?
    private var router: SignUpUserRouter
    
    init(view: SignUpUserView, router: SignUpUserRouter) {
        self.view = view
        self.router = router
    }
    
    func didTapCreateAccount() {
        // TODO: Add user data validation
        guard let view = view else { return }
        Authentication.shared.signUp(
            user: .init(
                email: view.email,
                password: view.password,
                name: view.name,
                surname: view.surname,
                phoneNumber: view.phoneNumber,
                numberPlate: view.numberPlate
            )
        ) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let user):
                    print(user)
                    view.showBanner(title: "Success", subtitle: "User created successfully", style: .success)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        view.closeController()
                    }
                case .failure(let error):
                    view.showBanner(title: "User creation failed", subtitle: error.localizedDescription, style: .danger)
                }
            }
        }
    }
}
