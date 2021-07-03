//
//  NoMembersCell.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 22.05.21.
//

import UIKit

class NoMembersCell: UITableViewCell {

    @IBOutlet weak var mainContainerView: UIView!
    
    @IBOutlet weak var descriptionTextLabel: UILabel!
    private var borderLayer: CAShapeLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        borderLayer?.removeFromSuperlayer()
//        borderLayer = mainContainerView.addLineDashedStroke(
//            pattern: [3, 3],
//            radius: 16,
//            lineWidht: 2,
//            color: UIColor.black.cgColor
//        )
        mainContainerView.layer.cornerRadius = 16
        mainContainerView.layer.borderWidth = 1
        mainContainerView.layer.borderColor = UIColor.black.cgColor
    }
    
}

extension NoMembersCell: CellViewModel {
    
    func configure(with model: CellModel) {
        if let model = model as? NoMembersCellModel {
            descriptionTextLabel.text = model.text
        }
    }
    
}
