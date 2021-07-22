//
//  MembershipRequest.swift
//  Core
//
//  Created by Vakhtang Kostava on 20.07.21.
//

import Foundation

public struct MembershipRequest: Codable {
    public let userId: String
    public let organizationId: String
    public let status: String
}
