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
    
    public func fetchAllMembershipRequest(completion: @escaping (_ result: Result<[MembershipRequest], Error>) -> Void) {
        membershipRequests.getData { (error, snapshot) in
            if let error = error {
                completion(.failure(error))
                return
            } else if snapshot.exists() {
                if let requestsData = snapshot.value as? [[String: Any?]],
                   let requestsJson = try? JSONSerialization.data(withJSONObject: requestsData, options: []),
                   let requests = try? JSONDecoder().decode([MembershipRequest].self, from: requestsJson) {
                    
                    completion(.success(requests))
                } else {
                    completion(.failure(DatabaseManagerNoDataError()))
                }
            } else {
                completion(.failure(DatabaseManagerNoDataError()))
            }
        }
    }
    
    enum MembershipRequestStatus: String {
        case pending, accept, decline
    }
    
    private func setMembershipRequest(
        status: MembershipRequestStatus,
        from userId: String,
        to organizationId: String,
        completion: @escaping (_ result: Result<String, Error>) -> Void
    ) {
        membershipRequests.getData { (error, snapshot) in
            if let error = error {
                completion(.failure(error))
                return
            } else if snapshot.exists() {
                if var requestsData = snapshot.value as? [[String: String]] {
                    for index in requestsData.indices {
                        if requestsData[index]["userId"] == userId && requestsData[index]["organizationId"] == organizationId {
                            requestsData[index]["status"] = status.rawValue
                            self.membershipRequests.setValue(requestsData)
                            break
                        }
                    }
                    completion(.success(String()))
                } else {
                    completion(.failure(DatabaseManagerNoDataError()))
                }
            } else {
                completion(.failure(DatabaseManagerNoDataError()))
            }
        }
    }
    
    private func set(organizationId: String, to userId: String, completion: @escaping (_ result: Result<String, Error>) -> Void) {
        self.usersReference.getData { (error, snapshot) in
            if let error = error {
                completion(.failure(error))
                return
            } else if snapshot.exists() {
                if var usersData = snapshot.value as? [[String: String]] {
                    for index in usersData.indices {
                        if usersData[index]["id"] == userId {
                            usersData[index]["organizationId"] = organizationId
                            self.usersReference.setValue(usersData)
                            break
                        }
                    }
                    completion(.success(String()))
                } else {
                    completion(.failure(DatabaseManagerNoDataError()))
                }
            } else {
                completion(.failure(DatabaseManagerNoDataError()))
            }
        }
    }
    
    public func declineMembershipRequest(from userId: String, to organizationId: String, completion: @escaping (_ result: Result<String, Error>) -> Void) {
        setMembershipRequest(status: .decline, from: userId, to: organizationId, completion: completion)
    }
    
    public func acceptMembershipRequest(from userId: String, to organizationId: String, completion: @escaping (_ result: Result<String, Error>) -> Void) {
        setMembershipRequest(status: .accept, from: userId, to: organizationId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.set(organizationId: organizationId, to: userId) { result in
                    switch result {
                    case .success:
                        completion(.success(String()))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

public struct DatabaseManagerNoDataError: Error {
    public let localizedDescription = "Couldn't load data"
}

