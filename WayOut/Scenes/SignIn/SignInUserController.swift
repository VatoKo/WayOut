//  
//  SignInUserController.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField
import NotificationBannerSwift

class SignInUserController: UIViewController {

    @IBOutlet weak var emailField: MDCOutlinedTextField!
    @IBOutlet weak var passwordField: MDCOutlinedTextField!
    @IBOutlet weak var signUpButton: MDCButton!
    @IBOutlet weak var signInButton: MDCButton!
    
    var loadingOverlay: UIAlertController?
    
    var presenter: SignInUserPresenter?

    @IBAction func signUpDidTap(_ sender: MDCButton) {
        presenter?.didTapSignUp()
    }
    
    @IBAction func signInDidTap(_ sender: MDCButton) {
        presenter?.didTapSignIn()
    }
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                var temp = self
                temp.showLoadingOverlay()
            } else {
                hideLoadingOverlay()
            }
        }
    }
    
}

extension SignInUserController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        emailField.label.text = "Email"
        emailField.keyboardType = .emailAddress
        passwordField.label.text = "Password"
        passwordField.isSecureTextEntry = true
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.setTitleFont(UIFont(name: "Futura", size: 14), for: .normal)
        signInButton.setBackgroundColor(.black)
        signInButton.layer.cornerRadius = 16
        signInButton.setElevation(.raisedButtonResting, for: .normal)
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.setTitleFont(UIFont(name: "Futura", size: 12), for: .normal)
        signUpButton.setBackgroundColor(.clear)
        
        emailField.text = "j.doe@gmail.com"
        passwordField.text = "qwerty123"
    }
    
}

extension SignInUserController: SignInUserView {
    
    var email: String {
        get { emailField.text ?? "" }
        set { emailField.text = newValue }
    }
    
    var password: String {
        get { passwordField.text ?? "" }
        set { passwordField.text = newValue }
    }
    
    func shakeFields() {
        emailField.shake()
        passwordField.shake()
    }
    
    func showBanner(title: String?, subtitle: String, style: BannerStyle) {
        let banner = NotificationBanner(
            title: title,
            subtitle: subtitle,
            style: style
        )
        banner.show()
    }
    
}

extension SignInUserController: Configurable {
    
    static func configured() -> SignInUserController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignInUserController") as! SignInUserController
        let configurator = SignInUserConfiguratorImpl()
        configurator.configure(vc)
        return vc
    }
    
}

extension SignInUserController: LoaderOverlayable {}

