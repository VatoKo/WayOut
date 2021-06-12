//
//  MyOrganizationCellModel.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 12.06.21.
//

import Foundation

struct MyOrganizationCellModel: CellModel {
    
    let organizationName: String
    let organizationEmail: String
    let numberOfMembers: String
    
    var cellIdentifier: String {
        return MyOrganizationCell.reuseIdentifier
    }
    
}
