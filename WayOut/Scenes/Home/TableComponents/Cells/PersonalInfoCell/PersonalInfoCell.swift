//
//  PersonalInfoCell.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 13.05.21.
//

import UIKit

class PersonalInfoCell: UITableViewCell {

    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberPlateLabel: UILabel!
    @IBOutlet weak var phoneNumberIcon: UIImageView!
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainContainerView.layer.cornerRadius = 16
        mainContainerView.layer.shadowColor = UIColor.black.cgColor
        mainContainerView.layer.shadowOpacity = 0.4
        mainContainerView.layer.shadowOffset = .zero
        mainContainerView.layer.shadowRadius = 4
        selectionStyle = .none
    }

    
}

extension PersonalInfoCell: CellViewModel {
    
    func configure(with model: CellModel) {
        if let model = model as? PersonalInfoCellModel {
            nameLabel.text = model.name
            numberPlateLabel.text = model.numberPlate
            phoneNumberLabel.text = model.phoneNumber
            emailLabel.text = model.email
        }
    }
    
}
