//  
//  OrganizationHomePresenter.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation
import Core
import NotificationBannerSwift

protocol OrganizationHomeView: AnyObject {
    func showBanner(title: String?, subtitle: String, style: BannerStyle)
}

protocol OrganizationHomePresenter {
    var tableDataSource: [CellModel] { get set }
    func viewDidLoad()
}

class OrganizationHomePresenterImpl: OrganizationHomePresenter {
    
    lazy var tableDataSource: [CellModel] = staticCellModels + (membersModels ?? [noMembersModel])
    
    private let organization: Organization
    private let members: [User]
    
    private weak var view: OrganizationHomeView?
    private var router: OrganizationHomeRouter
    
    init(
        view: OrganizationHomeView,
        router: OrganizationHomeRouter,
        organization: Organization,
        members: [User]
    ) {
        self.view = view
        self.router = router
        self.organization = organization
        self.members = members
    }
    
    func viewDidLoad() {
        
    }
    
    private func didTapMemberCell(model: MemberCellModel) {
        let member = members.first(where: { $0.id == model.id })!
        router.showMemberDialog(
            with: .init(
                numberPlate: member.numberPlate,
                name: "\(member.name) \(member.surname)",
                phoneNumber: member.phoneNumber,
                email: member.email
            )
        )
    }
    
    private func handleLogout() {
        
    }
}

extension OrganizationHomePresenterImpl {
    
    var staticCellModels: [CellModel] {
        return [
            GreetingCellModel(greetingText: "WayOut", didTapLogout: handleLogout),
            MyOrganizationCellModel(organizationName: organization.name, organizationEmail: organization.email, numberOfMembers: "\(members.count)"),
            TitleCellModel(title: "Your organization members")
        ]
    }
    
    var membersModels: [CellModel]? {
        if !members.isEmpty {
            return members.map {
                MemberCellModel(
                    id: $0.id,
                    name: "\($0.name) \($0.surname)",
                    numberPlate: $0.numberPlate,
                    didTapCell: didTapMemberCell(model:)
                )
            }
        } else {
            return nil
        }
    }
    
    var noMembersModel: CellModel {
        return NoMembersCellModel(text: "Your organization has no members yet")
    }
    
}
