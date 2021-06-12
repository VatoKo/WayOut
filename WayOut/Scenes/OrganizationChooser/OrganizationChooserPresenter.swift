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
}

protocol OrganizationChooserPresenter {
    var searchValue: String { get set }
    var tableDataSource: [OrganizationCellModel] { get set }
    func viewDidLoad()
}

class OrganizationChooserPresenterImpl: OrganizationChooserPresenter {
    
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
    
    init(view: OrganizationChooserView, router: OrganizationChooserRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        OrganizationManager.shared.fetchAllOrganizations { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let organizations):
                    self.tableDataSource = organizations.map {
                        MyOrganizationCellModel(
                            organizationName: $0.name,
                            organizationEmail: $0.email,
                            numberOfMembers: "123",
                            showsJoinButton: true,
                            didTapJoin: self.handleJoinDidTap
                        )
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
                print("TODO: Send membership request to \(model.organizationName)")
            }
        )
    }
    
}
