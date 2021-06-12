//
//  Organization.swift
//  Core
//
//  Created by Vakhtang Kostava on 09.05.21.
//

import Foundation

public struct Organization: Decodable {
    public let id: String
    public let name: String
    public let email: String
    
    public init(
        id: String,
        name: String,
        email: String
    ) {
        self.id = id
        self.name = name
        self.email = email
    }
}
