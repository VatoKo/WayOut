//
//  NoMembersCellModel.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 03.07.21.
//

import Foundation

struct NoMembersCellModel: CellModel {
        
    let text: String
    
    var cellIdentifier: String {
        return NoMembersCell.reuseIdentifier
    }
    
}
