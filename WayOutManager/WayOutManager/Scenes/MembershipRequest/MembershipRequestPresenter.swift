//  
//  MembershipRequestPresenter.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 20.07.21.
//

import Foundation
import Core

protocol MembershipRequestView: AnyObject {
    func reloadList()
}

protocol MembershipRequestPresenter {
    var tableDataSource: [CellModel] { get }
    func viewDidLoad()
}

class MembershipRequestPresenterImpl: MembershipRequestPresenter {
    
    private weak var view: MembershipRequestView?
    private var router: MembershipRequestRouter
    
    var tableDataSource: [CellModel] {
        return requestSendingUsers.map {
            MembershipRequestCellModel(
                userId: $0.id,
                name: "\($0.name) \($0.surname)",
                numberPlate: $0.numberPlate,
                didTapInfo: { [weak self] model in self?.showInfo(of: model.userId) },
                didTapAccept: { [weak self] model in self?.acceptRequest(from: model.userId) },
                didTapDecline: { [weak self] model in self?.declineRequest(from: model.userId) }
            )
        }
    }
    
    private let organization: Organization
    private var activeRequests: [MembershipRequest] = []
    private var requestSendingUsers: [User] = [] {
        didSet {
            view?.reloadList()
        }
    }
    
    init(view: MembershipRequestView, router: MembershipRequestRouter, organization: Organization) {
        self.view = view
        self.router = router
        self.organization = organization
    }
    
    func viewDidLoad() {
        fetchMembershipRequests()
    }
    
    private func fetchMembershipRequests() {
        DatabaseManager.shared.fetchAllMembershipRequest { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let requests):
                    print("All requests: ", requests)
                    self.activeRequests = requests.filter { $0.organizationId == self.organization.id && $0.status == "pending" }
                    print("Active requests: ", self.activeRequests)
                    if !self.activeRequests.isEmpty {
                        self.fetchUsers()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func fetchUsers() {
        DatabaseManager.shared.fetchAllUsers { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.requestSendingUsers = users.filter { user in self.activeRequests.contains(where: { request in request.userId == user.id }) }
                    print("Request sending users: ", self.requestSendingUsers)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func showInfo(of userId: String) {
        let user = requestSendingUsers.first(where: { $0.id == userId })!
        router.showMemberDialog(
            with: .init(
                numberPlate: user.numberPlate,
                name: "\(user.name) \(user.surname)",
                phoneNumber: user.phoneNumber,
                email: user.email
            )
        )
    }
    
    private func acceptRequest(from userId: String) {
        print(userId)
    }
    
    private func declineRequest(from userId: String) {
        print(userId)
    }
    
}
