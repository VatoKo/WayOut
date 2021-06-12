//
//  JoinOrganizationCellModel.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 22.05.21.
//

import Foundation

struct JoinOrganizationCellModel: CellModel {
        
    let didTapJoinOrganization: () -> Void

    var cellIdentifier: String {
        return JoinOrganizationCell.reuseIdentifier
    }
    
}
