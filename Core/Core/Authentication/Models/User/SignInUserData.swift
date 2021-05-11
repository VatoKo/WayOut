//
//  SignInUserData.swift
//  Core
//
//  Created by Vakhtang Kostava on 09.05.21.
//

import Foundation

public struct SignInUserData {
    let email: String
    let password: String
    
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
