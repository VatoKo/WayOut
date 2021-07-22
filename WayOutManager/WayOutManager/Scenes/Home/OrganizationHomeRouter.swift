//  
//  OrganizationHomeRouter.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation
import Core

protocol OrganizationHomeRouter {
    func showMemberDialog(with model: MemberDialogModel)
    func openWelcomePage()
    func openNotifications(organization: Organization)
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
    
    func openWelcomePage() {
        controller?.navigationController?.popToRootViewController(animated: true)
    }
    
    func openNotifications(organization: Organization) {
        let vc = MembershipRequestController.configured(organization: organization)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
