//
//  TitleCell.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 22.05.21.
//

import UIKit

class TitleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
        
}

extension TitleCell: CellViewModel {
    
    func configure(with model: CellModel) {
        if let model = model as? TitleCellModel {
            titleLabel.text = model.title
        }
    }
    
}

