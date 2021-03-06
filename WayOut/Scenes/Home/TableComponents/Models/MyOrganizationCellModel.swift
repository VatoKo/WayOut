//
//  MyOrganizationCellModel.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 12.06.21.
//

import Foundation

protocol OrganizationCellModel: CellModel {
    var organizationName: String { get set }
}

struct MyOrganizationCellModel: OrganizationCellModel {
    
    let organizationId: String
    var organizationName: String
    let organizationEmail: String
    let numberOfMembers: String
    let showsJoinButton: Bool
    let didTapJoin: ((MyOrganizationCellModel) -> Void)?
    
    init(
        organizationId: String,
        organizationName: String,
        organizationEmail: String,
        numberOfMembers: String,
        showsJoinButton: Bool = false,
        didTapJoin: ((MyOrganizationCellModel) -> Void)? = nil
    ) {
        self.organizationId = organizationId
        self.organizationName = organizationName
        self.organizationEmail = organizationEmail
        self.numberOfMembers = numberOfMembers
        self.showsJoinButton = showsJoinButton
        self.didTapJoin = didTapJoin
    }
    
    var cellIdentifier: String {
        return MyOrganizationCell.reuseIdentifier
    }
    
}
