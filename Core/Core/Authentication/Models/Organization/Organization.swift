//
//  Organization.swift
//  Core
//
//  Created by Vakhtang Kostava on 09.05.21.
//

import Foundation

public struct Organization: Decodable {
    let id: String
    let name: String
    let email: String
    
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
