//  
//  MembershipRequestRouter.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 20.07.21.
//

import Foundation

protocol MembershipRequestRouter {
    func showMemberDialog(with model: MemberDialogModel)
}

class MembershipRequestRouterImpl: MembershipRequestRouter {
    
    private weak var controller: MembershipRequestController?
    
    init(_ controller: MembershipRequestController?) {
        self.controller = controller
    }
    
    func showMemberDialog(with model: MemberDialogModel) {
        let vc = MemberDialog.configured(with: model)
        controller?.present(vc, animated: true, completion: nil)
    }
    
}
