//
//  PersonalInfoCellModel.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 13.05.21.
//

import Foundation

struct PersonalInfoCellModel: CellModel {
    
    let name: String
    let numberPlate: String
    let phoneNumber: String
    let email: String
    
    var cellIdentifier: String {
        return PersonalInfoCell.reuseIdentifier
    }
    
}
