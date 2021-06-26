//  
//  OrganizationHomePresenter.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation

protocol OrganizationHomeView: AnyObject {
    
}

protocol OrganizationHomePresenter {
    
}

class OrganizationHomePresenterImpl: OrganizationHomePresenter {
    
    private weak var view: OrganizationHomeView?
    private var router: OrganizationHomeRouter
    
    init(view: OrganizationHomeView, router: OrganizationHomeRouter) {
        self.view = view
        self.router = router
    }
}
