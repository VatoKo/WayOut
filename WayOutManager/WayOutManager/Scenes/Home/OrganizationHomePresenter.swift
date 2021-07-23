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
    func reloadList()
}

protocol OrganizationHomePresenter {
    var tableDataSource: [CellModel] { get }
    func viewDidLoad()
}

class OrganizationHomePresenterImpl: OrganizationHomePresenter {
    
    var tableDataSource: [CellModel] { return staticCellModels + (membersModels ?? [noMembersModel]) }
    
    private let organization: Organization
    private var members: [User]
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(reloadMembers), name: .init("SHOULD_RELOAD_MEMBERS"), object: nil)
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
    
    private func handleNotifications() {
        router.openNotifications(organization: organization)
    }
    
    private func handleLogout() {
        Authentication.shared.logout { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success:
                    self.router.openWelcomePage()
                case .failure(let error):
                    self.view?.showBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
                }
            }
        }
    }
    
    @objc
    private func reloadMembers() {
        DatabaseManager.shared.fetchAllUsers { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.members = users.filter { $0.organizationId == self.organization.id }
                    self.view?.reloadList()
                case .failure(let error):
                    self.view?.showBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
                }
            }
        }
    }
    
}

extension OrganizationHomePresenterImpl {
    
    var staticCellModels: [CellModel] {
        return [
            GreetingCellModel(greetingText: "WayOut", didTapNotifications: handleNotifications, didTapLogout: handleLogout),
            MyOrganizationCellModel(organizationName: organization.name, organizationEmail: organization.email, numberOfMembers: "\(members.count)"),
            TitleCellModel(title: "Your organization members")
        ]
    }
    
    var membersModels: [CellModel]? {
        if !members.isEmpty {
            return members
                .sorted(by: { $0.numberPlate < $1.numberPlate })
                .map {
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
