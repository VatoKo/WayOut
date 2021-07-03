//
//  MemberCell.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 03.07.21.
//

import UIKit

class MemberCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberPlateLabel: UILabel!
    
    private var model: MemberCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        accessoryType = .disclosureIndicator
    }
    
    @IBAction func didTapCell(_ sender: UIButton) {
        guard let model = model else { return }
        model.didTapCell?(model)
    }
    
}

extension MemberCell: CellViewModel {
    
    func configure(with model: CellModel) {
        if let model = model as? MemberCellModel {
            self.model = model
            nameLabel.text = model.name
            numberPlateLabel.text = model.numberPlate
        }
    }
    
}
