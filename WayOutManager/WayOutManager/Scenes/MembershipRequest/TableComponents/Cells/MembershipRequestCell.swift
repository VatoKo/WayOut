//
//  MembershipRequestCell.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 22.07.21.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField

class MembershipRequestCell: UITableViewCell {

    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberPlateLabel: UILabel!
    @IBOutlet weak var approveButton: MDCButton!
    @IBOutlet weak var declineButton: MDCButton!
    
    private var model: MembershipRequestCellModel?
    private var infoTapHandler: ((_ model: MembershipRequestCellModel) -> Void)?
    private var acceptTapHandler: ((_ model: MembershipRequestCellModel) -> Void)?
    private var declineTapHandler: ((_ model: MembershipRequestCellModel) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        mainContainerView.layer.cornerRadius = 16
        mainContainerView.layer.borderWidth = 1
        mainContainerView.layer.borderColor = UIColor.black.cgColor
        
        approveButton.setTitle("Accept", for: .normal)
        approveButton.setTitleColor(.black, for: .normal)
        approveButton.setTitleFont(UIFont(name: "Futura", size: 14), for: .normal)
        approveButton.setBackgroundColor(.clear)
        approveButton.setBorderColor(.black, for: .normal)
        approveButton.setBorderWidth(1, for: .normal)
        approveButton.layer.cornerRadius = 16
        approveButton.setElevation(.raisedButtonResting, for: .normal)
        
        declineButton.setTitle("Decline", for: .normal)
        declineButton.setTitleColor(.white, for: .normal)
        declineButton.setTitleFont(UIFont(name: "Futura", size: 14), for: .normal)
        declineButton.setBackgroundColor(.black)
        declineButton.layer.cornerRadius = 16
        declineButton.setElevation(.raisedButtonResting, for: .normal)
    }
    
    @IBAction
    private func didTapInfo() {
        guard let model = model else { return }
        infoTapHandler?(model)
    }
    
    @IBAction
    private func didTapAccepts() {
        guard let model = model else { return }
        acceptTapHandler?(model)
    }
    
    @IBAction
    private func didTapDecline() {
        guard let model = model else { return }
        declineTapHandler?(model)
    }
    
}

extension MembershipRequestCell: CellViewModel {
    
    func configure(with model: CellModel) {
        if let model = model as? MembershipRequestCellModel {
            self.model = model
            infoTapHandler = model.didTapInfo
            acceptTapHandler = model.didTapAccept
            declineTapHandler = model.didTapDecline
            nameLabel.text = model.name
            numberPlateLabel.text = model.numberPlate
        }
    }
    
}
