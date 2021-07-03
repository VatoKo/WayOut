//
//  GreetingCellModel.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation

struct GreetingCellModel: CellModel {
    
    let greetingText: String
    let didTapLogout: () -> Void
    
    var cellIdentifier: String {
        return GreetingCell.reuseIdentifier
    }
    
}
