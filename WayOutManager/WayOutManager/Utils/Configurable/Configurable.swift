//
//  Configurable.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation

protocol Configurable {
    associatedtype ObjectType = Self
    static func configured() -> ObjectType
}
