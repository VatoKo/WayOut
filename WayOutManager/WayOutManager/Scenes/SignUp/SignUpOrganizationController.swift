//  
//  SignUpOrganizationController.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import NotificationBannerSwift

public class SignUpOrganizationController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameField: MDCOutlinedTextField!
    @IBOutlet weak var emailField: MDCOutlinedTextField!
    @IBOutlet weak var passwordField: MDCOutlinedTextField!
    @IBOutlet weak var repeatPasswordField: MDCOutlinedTextField!
    @IBOutlet weak var createAccountButton: MDCButton!
    
    var presenter: SignUpOrganizationPresenter!

    @IBAction func didTapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCreateAccount(_ sender: MDCButton) {
        presenter.didTapCreateAccount()
    }
    
}

extension SignUpOrganizationController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        nameField.label.text = "Organization Name"
        emailField.label.text = "Email"
        emailField.keyboardType = .emailAddress
        passwordField.label.text = "Password"
        passwordField.isSecureTextEntry = true
        repeatPasswordField.label.text = "Repeat Password"
        repeatPasswordField.isSecureTextEntry = true
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.setTitleFont(UIFont(name: "Futura", size: 14), for: .normal)
        createAccountButton.setBackgroundColor(.black)
        createAccountButton.layer.cornerRadius = 16
        createAccountButton.setElevation(.raisedButtonResting, for: .normal)
    }
    
}

extension SignUpOrganizationController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case nameField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            repeatPasswordField.becomeFirstResponder()
        case repeatPasswordField:
            view.endEditing(true)
        default:
            break
        }
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(.init(x: 0, y: textField.superview!.frame.origin.y + (textField.frame.origin.y)), animated: true)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(.init(x: 0, y: 0), animated: true)
    }
}

extension SignUpOrganizationController: SignUpOrganizationView {
    
    var name: String {
        get { nameField.text ?? String() }
        set { nameField.text = newValue }
    }
    
    var email: String {
        get { emailField.text ?? String() }
        set { emailField.text = newValue }
    }
    
    var password: String {
        get { passwordField.text ?? String() }
        set { passwordField.text = newValue }
    }
    
    var repeatPassword: String {
        get { repeatPasswordField.text ?? String() }
        set { repeatPasswordField.text = newValue }
    }
    
    func showBanner(title: String?, subtitle: String, style: BannerStyle) {
        let banner = NotificationBanner(
            title: title,
            subtitle: subtitle,
            style: style
        )
        banner.show()
    }
    
    func closeController() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SignUpOrganizationController: Configurable {
    
    public static func configured() -> SignUpOrganizationController {
        let storyboard = UIStoryboard(name: "ManagerMain", bundle: Bundle(identifier: "WayOut.WayOutManager"))
        let vc = storyboard.instantiateViewController(identifier: "SignUpOrganizationController") as! SignUpOrganizationController
        let configurator = SignUpOrganizationConfiguratorImpl()
        configurator.configure(vc)
        return vc
    }
    
}

