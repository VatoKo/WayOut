//
//  Configurable.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 11.05.21.
//

import Foundation

protocol Configurable {
    associatedtype ObjectType = Self
    static func configured() -> ObjectType
}
