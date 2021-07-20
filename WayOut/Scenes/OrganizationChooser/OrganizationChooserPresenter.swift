//  
//  OrganizationChooserPresenter.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 12.06.21.
//

import Foundation
import Core
import NotificationBannerSwift

protocol OrganizationChooserView: AnyObject {
    func showPopup(title: String, subtitle: String, completion: @escaping () -> Void)
    func showBanner(title: String?, subtitle: String, style: BannerStyle)
    func reloadList()
    func closeController()
}

protocol OrganizationChooserPresenter {
    var searchValue: String { get set }
    var tableDataSource: [OrganizationCellModel] { get set }
    func viewDidLoad()
}

class OrganizationChooserPresenterImpl: OrganizationChooserPresenter {
    
    
    private let user: User
    
    var searchValue: String = String() {
        didSet {
            view?.reloadList()
        }
    }
    
    private var currentDataSource: [OrganizationCellModel] = [] {
        didSet {
            view?.reloadList()
        }
    }
    
    var tableDataSource: [OrganizationCellModel] {
        get {
            if searchValue.isEmpty {
                return currentDataSource
            } else {
                return currentDataSource.filter { $0.organizationName.lowercased().hasPrefix(searchValue.lowercased()) }
            }
        }
        set {
            currentDataSource = newValue
        }
    }

    
    private weak var view: OrganizationChooserView?
    private var router: OrganizationChooserRouter
    
    init(view: OrganizationChooserView, router: OrganizationChooserRouter, user: User) {
        self.view = view
        self.router = router
        self.user = user
    }
    
    func viewDidLoad() {
        let manager = DatabaseManager.shared
        manager.fetchAllOrganizations { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let organizations):
                    manager.fetchAllUsers { [weak self] result in
                        guard let self = self else { return }
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let users):
                                self.tableDataSource = organizations.map { organization in
                                    MyOrganizationCellModel(
                                        organizationId: organization.id,
                                        organizationName: organization.name,
                                        organizationEmail: organization.email,
                                        numberOfMembers: "\(users.filter({ user in user.organizationId == organization.id }).count)",
                                        showsJoinButton: true,
                                        didTapJoin: self.handleJoinDidTap
                                    )
                                }
                            case .failure(let error):
                                self.view?.showBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
                            }
                        }
                    }
                case .failure(let error):
                    self.view?.showBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
                }
            }
        }
    }
    
    private func handleJoinDidTap(model: MyOrganizationCellModel) {
        view?.showPopup(
            title: "Membership request",
            subtitle: "Do you really want to join \(model.organizationName)?",
            completion: {
                DatabaseManager.shared.sendMembershipRequest(userId: self.user.id, organizationId: model.organizationId)
                self.view?.showBanner(title: "Request Sent", subtitle: "Membership request to \(model.organizationName) sent successfully", style: .success)
                NotificationCenter.default.post(name: .init("MEMBERSHIP_REQUEST_DID_SEND"), object: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.view?.closeController()
                }
            }
        )
    }
    
}
