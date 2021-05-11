//
//  SignUpOrganizationData.swift
//  Core
//
//  Created by Vakhtang Kostava on 09.05.21.
//

import Foundation

public struct SignUpOrganizationData {
    let email: String
    let password: String
    let name: String
    
    public init(
        email: String,
        password: String,
        name: String
    ) {
        self.email = email
        self.password = password
        self.name = name
    }
}
