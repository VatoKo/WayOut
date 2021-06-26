//  
//  OrganizationHomeController.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import UIKit

public class OrganizationHomeController: UIViewController {

    var presenter: OrganizationHomePresenter?

    
}

extension OrganizationHomeController: OrganizationHomeView {
    
}

extension OrganizationHomeController: Configurable {
    
    public static func configured() -> OrganizationHomeController {
        let storyboard = UIStoryboard(name: "ManagerMain", bundle: Bundle(identifier: "WayOut.WayOutManager"))
        let vc = storyboard.instantiateViewController(identifier: "OrganizationHomeController") as! OrganizationHomeController
        let configurator = OrganizationHomeConfiguratorImpl()
        configurator.configure(vc)
        return vc
    }
    
}

