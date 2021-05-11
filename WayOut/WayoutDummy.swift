//
//  WayoutDummy.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 08.05.21.
//

import Foundation
import Core
import WayOutManager

public class WayoutDummy {
    
    public init() {
        let coreDummy = CoreDummy()
        let managerDummy = WayoutManagerDummy()
        let auth = Authentication.shared
        print("WayOut dummy")
    }
    
}
