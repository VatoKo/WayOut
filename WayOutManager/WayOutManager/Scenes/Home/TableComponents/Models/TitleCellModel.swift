//
//  TitleCellModel.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 03.07.21.
//

import Foundation

struct TitleCellModel: CellModel {
    
    let title: String
    
    var cellIdentifier: String {
        return TitleCell.reuseIdentifier
    }
    
}
