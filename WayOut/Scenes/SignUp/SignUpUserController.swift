//  
//  SignUpUserController.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class SignUpUserController: UIViewController {
    
    var presenter: SignUpUserPresenter?

    
}

extension SignUpUserController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension SignUpUserController: UITextFieldDelegate {
    
    
    
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
    
}

