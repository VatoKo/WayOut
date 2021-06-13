//  
//  SignUpUserController.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import NotificationBannerSwift

class SignUpUserController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameField: MDCOutlinedTextField!
    @IBOutlet weak var surnameField: MDCOutlinedTextField!
    @IBOutlet weak var emailField: MDCOutlinedTextField!
    @IBOutlet weak var passwordField: MDCOutlinedTextField!
    @IBOutlet weak var repeatPassworField: MDCOutlinedTextField!
    @IBOutlet weak var phoneNumberField: MDCOutlinedTextField!
    @IBOutlet weak var numberPlateFIeld: MDCOutlinedTextField!
    @IBOutlet weak var createAccountButton: MDCButton!
    
    
    var presenter: SignUpUserPresenter!

    @IBAction func didTapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCreateAccount(_ sender: MDCButton) {
        presenter.didTapCreateAccount()
    }
    
}

extension SignUpUserController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.label.text = "Name"
        surnameField.label.text = "Surname"
        emailField.label.text = "Email"
        emailField.keyboardType = .emailAddress
        passwordField.label.text = "Password"
        passwordField.isSecureTextEntry = true
        repeatPassworField.label.text = "Repeat Password"
        repeatPassworField.isSecureTextEntry = true
        phoneNumberField.label.text = "Phone Number"
        phoneNumberField.keyboardType = .numberPad
        numberPlateFIeld.label.text = "Number Plate"
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.setTitleFont(UIFont(name: "Futura", size: 14), for: .normal)
        createAccountButton.setBackgroundColor(.black)
        createAccountButton.layer.cornerRadius = 16
        createAccountButton.setElevation(.raisedButtonResting, for: .normal)
    }
    
}

extension SignUpUserController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case nameField:
            surnameField.becomeFirstResponder()
        case surnameField:
            phoneNumberField.becomeFirstResponder()
        case phoneNumberField:
            numberPlateFIeld.becomeFirstResponder()
        case numberPlateFIeld:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            repeatPassworField.becomeFirstResponder()
        case repeatPassworField:
            view.endEditing(true)
        default:
            break
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(.init(x: 0, y: textField.superview!.frame.origin.y + (textField.frame.origin.y)), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(.init(x: 0, y: 0), animated: true)
    }
}

extension SignUpUserController: Configurable {
    
    static func configured() -> SignUpUserController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignUpUserController") as! SignUpUserController
        let configurator = SignUpUserConfiguratorImpl()
        configurator.configure(vc)
        return vc
    }
    
}

extension SignUpUserController: SignUpUserView {
    
    var name: String {
        get { nameField.text ?? String() }
        set { nameField.text = newValue }
    }
    
    var surname: String {
        get { surnameField.text ?? String() }
        set { surnameField.text = newValue }
    }
    
    var phoneNumber: String {
        get { phoneNumberField.text ?? String() }
        set { phoneNumberField.text = newValue }
    }
    
    var numberPlate: String {
        get { numberPlateFIeld.text ?? String() }
        set { numberPlateFIeld.text = newValue }
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
        get { repeatPassworField.text ?? String() }
        set { repeatPassworField.text = newValue }
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

