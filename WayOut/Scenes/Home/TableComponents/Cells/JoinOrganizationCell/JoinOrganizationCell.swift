//
//  JoinOrganizationCell.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 22.05.21.
//

import UIKit

class JoinOrganizationCell: UITableViewCell {

    @IBOutlet weak var mainContainerView: UIView!
    
    private var borderLayer: CAShapeLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderLayer?.removeFromSuperlayer()
        borderLayer = mainContainerView.addLineDashedStroke(
            pattern: [3, 3],
            radius: 16,
            lineWidht: 2,
            color: UIColor.black.cgColor
        )
    }
    
}

extension JoinOrganizationCell: CellViewModel {
    
    func configure(with model: CellModel) {
        if let model = model as? JoinOrganizationCellModel {
            
        }
    }
    
}
