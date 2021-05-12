//
//  User.swift
//  Core
//
//  Created by Vakhtang Kostava on 09.05.21.
//

import Foundation

public struct User: Decodable {
    public let id: String
    public let name: String
    public let surname: String
    public let phoneNumber: String
    public let email: String
    public let numberPlate: String
    public let organizationId: String?
    
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
