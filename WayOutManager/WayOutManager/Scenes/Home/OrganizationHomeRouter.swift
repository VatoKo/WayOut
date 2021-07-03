//  
//  OrganizationHomeRouter.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation

protocol OrganizationHomeRouter {
    func showMemberDialog(with model: MemberDialogModel)
}

class OrganizationHomeRouterImpl: OrganizationHomeRouter {
    
    private weak var controller: OrganizationHomeController?
    
    init(_ controller: OrganizationHomeController?) {
        self.controller = controller
    }
    
    func showMemberDialog(with model: MemberDialogModel) {
        let vc = MemberDialog.configured(with: model)
        controller?.present(vc, animated: true, completion: nil)
    }
    
}
