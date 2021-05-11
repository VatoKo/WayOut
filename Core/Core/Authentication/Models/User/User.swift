//
//  User.swift
//  Core
//
//  Created by Vakhtang Kostava on 09.05.21.
//

import Foundation

public struct User: Decodable {
    let id: String
    let name: String
    let surname: String
    let phoneNumber: String
    let email: String
    let numberPlate: String
    let organizationId: String?
    
    public init(
        id: String,
        name: String,
        surname: String,
        phoneNumber: String,
        email: String,
        numberPlate: String,
        organizationId: String?
    ) {
        self.id = id
        self.name = name
        self.surname = surname
        self.phoneNumber = phoneNumber
        self.email = email
        self.numberPlate = numberPlate
        self.organizationId = organizationId
    }
}
