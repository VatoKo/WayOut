//
//  GreetingCell.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 13.05.21.
//

import UIKit

class GreetingCell: UITableViewCell {

    @IBOutlet weak var greetingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

extension GreetingCell: CellViewModel {
    
    func configure(with model: CellModel) {
        if let model = model as? GreetingCellModel {
            greetingLabel.text = model.greetingText
        }
    }
    
}
