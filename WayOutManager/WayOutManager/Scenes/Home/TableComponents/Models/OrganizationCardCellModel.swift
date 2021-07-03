//
//  OrganizationCardCellModel.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 03.07.21.
//

import Foundation

struct MyOrganizationCellModel: CellModel {
    
    var organizationName: String
    let organizationEmail: String
    let numberOfMembers: String
    
    var cellIdentifier: String {
        return MyOrganizationCell.reuseIdentifier
    }
    
}
