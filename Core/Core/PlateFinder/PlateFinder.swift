//
//  PlateFinder.swift
//  Core
//
//  Created by Vakhtang Kostava on 08.06.21.
//

import Foundation

public typealias PlateFinderCompletion = (_ result: Result<User, Error>) -> Void

public protocol PlateFinder {
    func findUser(with numberPlate: String, in organization: String, completion: @escaping PlateFinderCompletion)
}

public class PlateFinderImpl: DatabaseAccessible {
    
    public static let shared = PlateFinderImpl()
    
    private lazy var usersReference = databaseReference.child("users")
    
    
    private init() {}
    
}

extension PlateFinderImpl: PlateFinder {
    
    public func findUser(with numberPlate: String, in organization: String, completion: @escaping PlateFinderCompletion) {
        self.usersReference.getData { (error, snapshot) in
            if let error = error {
                completion(.failure(error))
                return
            } else if snapshot.exists() {
                if let usersData = snapshot.value as? [[String: Any?]],
                   let usersJson = try? JSONSerialization.data(withJSONObject: usersData, options: []),
                   let users = try? JSONDecoder().decode([User].self, from: usersJson) {
                    
                    if let foundUser = users.filter({ $0.organizationId == organization })
                                            .first(where: { $0.numberPlate == numberPlate }) {
                        completion(.success(foundUser))
                    } else {
                        completion(.failure(PlateFinderNoUserFoundError()))
                    }
                } else {
                    completion(.failure(PlateFinderGenericError()))
                }
            } else {
                completion(.failure(PlateFinderGenericError()))
            }
        }
    }
    
}

public protocol PlateFinderError: Error {
    var localizedDescription: String { get }
}

public struct PlateFinderNoUserFoundError: PlateFinderError {
    public let localizedDescription = "No user found in your organization with such number plate"
}

public struct PlateFinderGenericError: PlateFinderError {
    public let localizedDescription = "Unknown error occured"
}
