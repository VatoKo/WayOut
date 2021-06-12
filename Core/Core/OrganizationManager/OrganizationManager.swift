//
//  OrganizationManager.swift
//  Core
//
//  Created by Vakhtang Kostava on 12.06.21.
//

import Foundation

public class OrganizationManager: DatabaseAccessible {
    
    public static let shared = OrganizationManager()
    
    private lazy var organizationsReference = databaseReference.child("organizations")
    
    private init() {}
    
    
    public func fetchAllOrganizations(completion: @escaping (_ result: Result<[Organization], Error>) -> Void) {
        self.organizationsReference.getData { (error, snapshot) in
            if let error = error {
                completion(.failure(error))
                return
            } else if snapshot.exists() {
                if let organizationsData = snapshot.value as? [[String: Any?]],
                   let organizationsJson = try? JSONSerialization.data(withJSONObject: organizationsData, options: []),
                   let organizations = try? JSONDecoder().decode([Organization].self, from: organizationsJson) {
                    
                    completion(.success(organizations))
                } else {
                    completion(.failure(OrganizationManagerNoDataError()))
                }
            } else {
                completion(.failure(OrganizationManagerNoDataError()))
            }
        }
    }
    
}

public struct OrganizationManagerNoDataError: Error {
    public let localizedDescription = "Couldn't load data"
}

