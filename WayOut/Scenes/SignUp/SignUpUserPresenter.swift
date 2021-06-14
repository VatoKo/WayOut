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
    
    private static let PasswordValidationRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    private static let EmailValidationRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    private static let NumberplateValidationRegex = "[A-Z]{2}-[0-9]{3}-[A-Z]{2}"
    
    init(view: SignUpUserView, router: SignUpUserRouter) {
        self.view = view
        self.router = router
    }
    
    func didTapCreateAccount() {
        guard let view = view else { return }
        guard isDataValidated else { return }
        Authentication.shared.signUp(
            user: .init(
                email: view.email,
                password: view.password,
                name: view.name,
                surname: view.surname,
                phoneNumber: view.phoneNumber,
                numberPlate: view.numberPlate
            )
        ) { result in
            DispatchQueue.main.async {
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

// MARK: Data Validation
extension SignUpUserPresenterImpl {
    
    private var isDataValidated: Bool {
        guard let view = view else { return false }
        let fields = [
            view.name,
            view.surname,
            view.phoneNumber,
            view.numberPlate,
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
        
        if view.phoneNumber.count != 9 {
            view.showBanner(title: nil, subtitle: "The phone number is not valid", style: .warning)
            return false
        }
        
        if !view.password.matches(SignUpUserPresenterImpl.PasswordValidationRegex) {
            view.showBanner(title: nil, subtitle: "The password does not satisfy requirements", style: .warning)
            return false
        }
        
        if !view.email.matches(SignUpUserPresenterImpl.EmailValidationRegex) {
            view.showBanner(title: nil, subtitle: "The email is not in valid format", style: .warning)
            return false
        }
        
        if !view.numberPlate.matches(SignUpUserPresenterImpl.NumberplateValidationRegex) {
            view.showBanner(title: nil, subtitle: "Invalid number plate format", style: .warning)
            return false
        }
        
        return true
    }
    
}
