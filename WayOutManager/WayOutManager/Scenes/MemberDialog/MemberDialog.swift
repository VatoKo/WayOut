//
//  InfoDialog.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 05.06.21.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField

struct MemberDialogModel {
    let numberPlate: String
    let name: String
    let phoneNumber: String
    let email: String
}

class MemberDialog: UIViewController {
    
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var plateLabel: UILabel!
    @IBOutlet weak var sendEmailButton: MDCButton!
    @IBOutlet weak var callButton: MDCButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    var model: MemberDialogModel?
    
    @IBAction func didTapClose(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func didTapSendEmail(_ sender: MDCButton) {
        guard let model = model else { return }
        if let url = URL(string: "mailto:\(model.email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func didTapCall(_ sender: MDCButton) {
        guard let model = model else { return }
        if let url = URL(string: "tel://\(model.phoneNumber)") {
             UIApplication.shared.open(url)
         }
    }
    
}

// MARK: UIViewController Lifecycle
extension MemberDialog {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        prepareForAnimation()
        if let model = model {
            configure(with: model)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performAnimation()
    }
    
}

// MARK: Setup
extension MemberDialog {
    
    private func setup() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        dialogView.layer.cornerRadius = 16
        setupButtons()
    }
    
    private func setupButtons() {
        sendEmailButton.setTitle("Send Email", for: .normal)
        sendEmailButton.setTitleColor(.black, for: .normal)
        sendEmailButton.setTitleFont(UIFont(name: "Futura", size: 14), for: .normal)
        sendEmailButton.setBackgroundColor(.clear)
        sendEmailButton.setBorderColor(.black, for: .normal)
        sendEmailButton.setBorderWidth(1, for: .normal)
        sendEmailButton.layer.cornerRadius = 16
        sendEmailButton.setElevation(.raisedButtonResting, for: .normal)
        
        callButton.setTitle("Call", for: .normal)
        callButton.setTitleColor(.white, for: .normal)
        callButton.setTitleFont(UIFont(name: "Futura", size: 14), for: .normal)
        callButton.setBackgroundColor(.black)
        callButton.layer.cornerRadius = 16
        callButton.setElevation(.raisedButtonResting, for: .normal)
    }
    
}

// MARK: Configuration
extension MemberDialog {
    
    private func configure(with model: MemberDialogModel) {
        plateLabel.text = model.numberPlate
        nameLabel.text = model.name
        phoneNumberLabel.text = model.phoneNumber
        emailLabel.text = model.email
    }
    
}

// MARK:- Dialog Animations
extension MemberDialog {
    
    private func prepareForAnimation() {
        dialogView.alpha = 0
        dialogView.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    private func performAnimation() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0,
            options: .curveEaseOut,
            animations: {
                self.dialogView.alpha = 1
                self.dialogView.transform = .identity
            },
            completion: nil
        )
    }
}

extension MemberDialog {
    
    static func configured(with model: MemberDialogModel) -> MemberDialog {
        let storyboard = UIStoryboard(name: "ManagerMain", bundle: Bundle(identifier: "WayOut.WayOutManager"))
        let vc = storyboard.instantiateViewController(identifier: "MemberDialog") as! MemberDialog
        vc.model = model
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }
    
}
