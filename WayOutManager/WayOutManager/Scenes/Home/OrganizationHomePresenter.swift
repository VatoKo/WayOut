//  
//  OrganizationHomePresenter.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation
import Core

protocol OrganizationHomeView: AnyObject {
    
}

protocol OrganizationHomePresenter {
    var tableDataSource: [CellModel] { get set }
    func viewDidLoad()
}

class OrganizationHomePresenterImpl: OrganizationHomePresenter {
    
    var tableDataSource: [CellModel] = [
        GreetingCellModel(greetingText: "WayOut", didTapLogout: {})
    ]
    
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
        print("Organization: ", organization)
        print("Members: ", members)
    }
}
