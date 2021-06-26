//  
//  SignInOrganizationController.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField

public class SignInOrganizationController: UIViewController {

    @IBOutlet weak var emailField: MDCOutlinedTextField!
    @IBOutlet weak var passwordField: MDCOutlinedTextField!
    @IBOutlet weak var signUpButton: MDCButton!
    @IBOutlet weak var signInButton: MDCButton!
    
    var presenter: SignInOrganizationPresenter!
    
    @IBAction func signUpDidTap(_ sender: MDCButton) {
        presenter.didTapSignUp()
    }
    
    @IBAction func signInDidTap(_ sender: MDCButton) {
        presenter.didTapSignIn()
    }

    
}

extension SignInOrganizationController {
    
    public override func viewDidLoad() {
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
    }
    
}

extension SignInOrganizationController: SignInOrganizationView {
    
}

extension SignInOrganizationController: Configurable {
    
    public static func configured() -> SignInOrganizationController {
        let storyboard = UIStoryboard(name: "ManagerMain", bundle: Bundle(identifier: "WayOut.WayOutManager"))
        let vc = storyboard.instantiateViewController(identifier: "SignInOrganizationController") as! SignInOrganizationController
        let configurator = SignInOrganizationConfiguratorImpl()
        configurator.configure(vc)
        return vc
    }
    
}
