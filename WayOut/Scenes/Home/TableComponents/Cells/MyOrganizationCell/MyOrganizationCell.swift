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
    @IBOutlet weak var joinButton: UIButton!
    
    private var model: MyOrganizationCellModel?
    private var didTapJoin: ((MyOrganizationCellModel) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        mainContainerView.layer.cornerRadius = 16
        mainContainerView.layer.borderWidth = 1
        mainContainerView.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func didTapJoin(_ sender: UIButton) {
        guard let model = model else { return }
        didTapJoin?(model)
    }
    
}

extension MyOrganizationCell: CellViewModel {
    
    func configure(with model: CellModel) {
        if let model = model as? MyOrganizationCellModel {
            self.model = model
            organizationNameLabel.text = model.organizationName
            organizationEmailLabel.text = model.organizationEmail
            numberOfMembersLabel.text = model.numberOfMembers
            joinButton.isHidden = !model.showsJoinButton
            didTapJoin = model.didTapJoin
        }
    }
    
}
