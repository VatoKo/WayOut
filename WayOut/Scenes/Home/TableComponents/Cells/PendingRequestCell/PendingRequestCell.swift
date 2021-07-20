//
//  PendingRequestCell.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 04.07.21.
//

import UIKit

class PendingRequestCell: UITableViewCell {

    @IBOutlet weak var mainContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        mainContainerView.layer.cornerRadius = 16
        mainContainerView.layer.borderWidth = 1
        mainContainerView.layer.borderColor = UIColor.black.cgColor
    }
    
}

extension PendingRequestCell: CellViewModel {
    
    func configure(with model: CellModel) {
        if let model = model as? PendingRequestCellModel {
            
        }
    }
    
}
