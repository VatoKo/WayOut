//
//  MyOrganizationCell.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 12.06.21.
//

import UIKit

class MyOrganizationCell: UITableViewCell {

    @IBOutlet private weak var mainContainerView: UIView!
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var organizationEmailLabel: UILabel!
    @IBOutlet weak var numberOfMembersLabel: UILabel!
    
    private var model: MyOrganizationCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        mainContainerView.layer.cornerRadius = 16
        mainContainerView.layer.borderWidth = 1
        mainContainerView.layer.borderColor = UIColor.black.cgColor
        
        mainContainerView.layer.shadowColor = UIColor.black.cgColor
        mainContainerView.layer.shadowOpacity = 0.4
        mainContainerView.layer.shadowOffset = .zero
        mainContainerView.layer.shadowRadius = 4
    }
    
}

extension MyOrganizationCell: CellViewModel {
    
    func configure(with model: CellModel) {
        if let model = model as? MyOrganizationCellModel {
            self.model = model
            organizationNameLabel.text = model.organizationName
            organizationEmailLabel.text = model.organizationEmail
            numberOfMembersLabel.text = model.numberOfMembers
        }
    }
    
}
