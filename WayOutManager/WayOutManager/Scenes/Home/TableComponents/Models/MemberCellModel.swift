//
//  MemberCellModel.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 03.07.21.
//

import Foundation

struct MemberCellModel: CellModel {
    
    let id: String
    let name: String
    let numberPlate: String
    let didTapCell: ((_ model: MemberCellModel) -> Void)?
    
    var cellIdentifier: String {
        return MemberCell.reuseIdentifier
    }
    
}
