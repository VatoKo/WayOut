//
//  MembershipRequestCellModel.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 22.07.21.
//

import Foundation

struct MembershipRequestCellModel: CellModel {
    
    let userId: String
    let name: String
    let numberPlate: String
    let didTapInfo: (_ model: MembershipRequestCellModel) -> Void
    let didTapAccept: (_ model: MembershipRequestCellModel) -> Void
    let didTapDecline: (_ model: MembershipRequestCellModel) -> Void
    
    var cellIdentifier: String {
        return MembershipRequestCell.reuseIdentifier
    }
    
}
