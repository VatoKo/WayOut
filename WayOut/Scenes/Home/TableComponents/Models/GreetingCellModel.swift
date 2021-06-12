//
//  GreetingCellModel.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 13.05.21.
//

import Foundation

struct GreetingCellModel: CellModel {
    
    let greetingText: String
    let didTapLogout: () -> Void
    
    var cellIdentifier: String {
        return GreetingCell.reuseIdentifier
    }
    
}
