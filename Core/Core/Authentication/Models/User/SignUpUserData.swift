//
//  SignUpUserData.swift
//  Core
//
//  Created by Vakhtang Kostava on 09.05.21.
//

import Foundation

public struct SignUpUserData {
    let email: String
    let password: String
    let name: String
    let surname: String
    let phoneNumber: String
    let numberPlate: String
    
    public init(
        email: String,
        password: String,
        name: String,
        surname: String,
        phoneNumber: String,
        numberPlate: String
    ) {
        self.email = email
        self.password = password
        self.name = name
        self.surname = surname
        self.phoneNumber = phoneNumber
        self.numberPlate = numberPlate
    }
}
