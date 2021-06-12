//  
//  WelcomeController.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import UIKit
import MaterialComponents.MaterialButtons

class WelcomeController: UIViewController {

    @IBOutlet weak var illustration: UIImageView!
    @IBOutlet weak var organizationButton: MDCButton!
    @IBOutlet weak var userButton: MDCButton!
    
    var presenter: WelcomePresenter?

    @IBAction func organizationDidTap(_ sender: MDCButton) {
        presenter?.didTapOrganization()
    }
    
    @IBAction func userDidTap(_ sender: MDCButton) {
        presenter?.didTapUser()
    }
    
}

extension WelcomeController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WelcomeConfiguratorImpl().configure(self)
        
        illustration.clipsToBounds = true
        
        organizationButton.setTitle("Organization", for: .normal)
        organizationButton.setTitleColor(.black, for: .normal)
        organizationButton.setTitleFont(UIFont(name: "Futura", size: 14), for: .normal)
        organizationButton.setBackgroundColor(.clear)
        organizationButton.setBorderColor(.black, for: .normal)
        organizationButton.setBorderWidth(1, for: .normal)
        organizationButton.layer.cornerRadius = 16
        organizationButton.setElevation(.raisedButtonResting, for: .normal)
        
        userButton.setTitle("User", for: .normal)
        userButton.setTitleColor(.white, for: .normal)
        userButton.setTitleFont(UIFont(name: "Futura", size: 14), for: .normal)
        userButton.setBackgroundColor(.black)
        userButton.layer.cornerRadius = 16
        userButton.setElevation(.raisedButtonResting, for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        illustration.layer.cornerRadius = illustration.frame.width / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension WelcomeController: WelcomeView {
    
}

extension WelcomeController: Configurable {
    
    static func configured() -> WelcomeController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "WelcomeController") as! WelcomeController
        let configurator = WelcomeConfiguratorImpl()
        configurator.configure(vc)
        return vc
    }
    
}

