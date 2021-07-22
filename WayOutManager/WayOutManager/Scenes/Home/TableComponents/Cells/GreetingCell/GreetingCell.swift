//
//  GreetingCell.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 13.05.21.
//

import UIKit

class GreetingCell: UITableViewCell {

    @IBOutlet weak var greetingLabel: UILabel!
    
    private var didTapNotifications: (() -> Void)?
    private var didTapLogout: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    @IBAction func didTapNotifications(_ sneder: UIButton) {
        didTapNotifications?()
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        didTapLogout?()
    }
}

extension GreetingCell: CellViewModel {
    
    func configure(with model: CellModel) {
        if let model = model as? GreetingCellModel {
            greetingLabel.text = model.greetingText
            didTapNotifications = model.didTapNotifications
            didTapLogout = model.didTapLogout
        }
    }
    
}
