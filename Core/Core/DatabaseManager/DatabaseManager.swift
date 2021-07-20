//
//  DatabaseManager.swift
//  Core
//
//  Created by Vakhtang Kostava on 12.06.21.
//

import Foundation

public class DatabaseManager: DatabaseAccessible {
    
    public static let shared = DatabaseManager()
    
    private lazy var organizationsReference = databaseReference.child("organizations")
    private lazy var usersReference = databaseReference.child("users")
    private lazy var membershipRequests = databaseReference.child("membership_requests")
    
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
                    completion(.failure(DatabaseManagerNoDataError()))
                }
            } else {
                completion(.failure(DatabaseManagerNoDataError()))
            }
        }
    }
    
    public func fetchAllUsers(completion: @escaping (_ result: Result<[User], Error>) -> Void) {
        self.usersReference.getData { (error, snapshot) in
            if let error = error {
                completion(.failure(error))
                return
            } else if snapshot.exists() {
                if let usersData = snapshot.value as? [[String: Any?]],
                   let usersJson = try? JSONSerialization.data(withJSONObject: usersData, options: []),
                   let users = try? JSONDecoder().decode([User].self, from: usersJson) {
                    
                    completion(.success(users))
                } else {
                    completion(.failure(DatabaseManagerNoDataError()))
                }
            } else {
                completion(.failure(DatabaseManagerNoDataError()))
            }
        }
    }
    
    public func sendMembershipRequest(userId: String, organizationId: String) {
        let requestData = [
            "userId": userId,
            "organizationId": organizationId,
            "status": "pending"
        ]
        
        self.membershipRequests.getData { (error, snapshot) in
            if let _ = error {
                return
            } else if snapshot.exists() {
                if var requests = snapshot.value as? [[String: Any?]] {
                    requests.append(requestData)
                    self.membershipRequests.setValue(requests)
                }
            } else {
                self.membershipRequests.setValue([requestData])
            }
        }
    }
    
}

public struct DatabaseManagerNoDataError: Error {
    public let localizedDescription = "Couldn't load data"
}

