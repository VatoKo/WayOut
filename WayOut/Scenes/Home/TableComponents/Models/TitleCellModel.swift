//
//  TitleCellModel.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 22.05.21.
//

import Foundation

struct TitleCellModel: CellModel {
    
    let title: String
    
    var cellIdentifier: String {
        return TitleCell.reuseIdentifier
    }
    
}
