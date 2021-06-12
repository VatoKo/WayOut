//
//  Authentication.swift
//  Core
//
//  Created by Vakhtang Kostava on 09.05.21.
//

import Foundation
import Firebase

public class Authentication: DatabaseAccessible {
    
    public static let shared = Authentication()
    
    private lazy var usersReference = databaseReference.child("users")
    private lazy var organizationsReference = databaseReference.child("organizations")
    
    private init() {}
    
}


// MARK: Sign Up
public extension Authentication {
    
    typealias SignUpUserCompletion = (_ result: Result<User, Error>) -> Void
    typealias SignUpOrganizationCompletion = (_ result: Result<Organization, Error>) -> Void
    
    // MARK: Sign Up User
    
    func signUp(user data: SignUpUserData, completion: @escaping SignUpUserCompletion) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                completion(.failure(error ?? SignUpError()))
                return
            }
            
            self.usersReference.getData { (error, snapshot) in
                let userDataDict = [
                    "id": user.uid,
                    "name": data.name,
                    "surname": data.surname,
                    "phoneNumber": data.phoneNumber,
                    "email": data.email,
                    "numberPlate": data.numberPlate,
                    "organizationId": nil
                ]
                
                if let error = error {
                    completion(.failure(error))
                    return
                } else if snapshot.exists() {
                    if var users = snapshot.value as? [[String: Any?]] {
                        users.append(userDataDict)
                        self.usersReference.setValue(users)
                    }
                } else {
                    self.usersReference.setValue([userDataDict])
                }
                
                completion(
                    .success(
                        User(
                            id: user.uid,
                            name: data.name,
                            surname: data.surname,
                            phoneNumber: data.phoneNumber,
                            email: data.email,
                            numberPlate: data.numberPlate,
                            organizationId: nil
                        )
                    )
                )
            }
        }
    }
    
    // MARK: Sign Up Organization
    
    func signUp(organization data: SignUpOrganizationData, completion: @escaping SignUpOrganizationCompletion) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { (authResult, error) in
            guard let organization = authResult?.user, error == nil else {
                completion(.failure(error ?? SignUpError()))
                return
            }
            
            self.organizationsReference.getData { (error, snapshot) in
                let organizationDataDict = [
                    "id": organization.uid,
                    "name": data.name,
                    "email": data.email
                ]
                
                if let error = error {
                    completion(.failure(error))
                    return
                } else if snapshot.exists() {
                    if var organizations = snapshot.value as? [[String: Any?]] {
                        organizations.append(organizationDataDict)
                        self.organizationsReference.setValue(organizations)
                    }
                } else {
                    self.organizationsReference.setValue([organizationDataDict])
                }
                
                completion(.success(Organization(id: organization.uid, name: data.name, email: data.email)))
            }
        }
    }
    
}


// MARK: Sign In
public extension Authentication {
    
    typealias SignInUserCompletion = (_ result: Result<User, Error>) -> Void
    typealias SignInOrganizationCompletion = (_ result: Result<Organization, Error>) -> Void
    
    // MARK: Sign In User
    
    func signIn(user data: SignInUserData, completion: @escaping SignInUserCompletion) {
        Auth.auth().signIn(withEmail: data.email, password: data.password) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                completion(.failure(error ?? SignInError()))
                return
            }
            
            self.usersReference.getData { (error, snapshot) in
                if let error = error {
                    try? Auth.auth().signOut()
                    completion(.failure(error))
                    return
                } else if snapshot.exists() {
                    if let usersData = snapshot.value as? [[String: Any?]],
                       let usersJson = try? JSONSerialization.data(withJSONObject: usersData, options: []),
                       let users = try? JSONDecoder().decode([User].self, from: usersJson) {
                        
                        if let signedInUser = users.first(where: { $0.id == user.uid }) {
                            completion(.success(signedInUser))
                        } else {
                            try? Auth.auth().signOut()
                            completion(.failure(SignInError()))
                        }
                        
                    } else {
                        try? Auth.auth().signOut()
                        completion(.failure(SignInError()))
                    }
                } else {
                    try? Auth.auth().signOut()
                    completion(.failure(SignInError()))
                }
            }
        }
    }
    
    //MARK: Sign In Organization
    
    func signIn(organization data: SignInOrganizationData, completion: @escaping SignInOrganizationCompletion) {
        Auth.auth().signIn(withEmail: data.email, password: data.password) { (authResult, error) in
            guard let organization = authResult?.user, error == nil else {
                completion(.failure(error ?? SignInError()))
                return
            }
            
            self.organizationsReference.getData { (error, snapshot) in
                if let error = error {
                    try? Auth.auth().signOut()
                    completion(.failure(error))
                    return
                } else if snapshot.exists() {
                    if let organizationsData = snapshot.value as? [[String: Any?]],
                       let organizationsJson = try? JSONSerialization.data(withJSONObject: organizationsData, options: []),
                       let organizations = try? JSONDecoder().decode([Organization].self, from: organizationsJson) {
                        
                        if let signedInOrganization = organizations.first(where: { $0.id == organization.uid }) {
                            completion(.success(signedInOrganization))
                        } else {
                            try? Auth.auth().signOut()
                            completion(.failure(SignInError()))
                        }
                        
                    } else {
                        try? Auth.auth().signOut()
                        completion(.failure(SignInError()))
                    }
                } else {
                    try? Auth.auth().signOut()
                    completion(.failure(SignInError()))
                }
            }
        }
    }
    
}

public extension Authentication {
    
    func logout(completion: ((_ result: Result<Int, Error>) -> Void)?) {
        do {
            try Auth.auth().signOut()
            completion?(.success(0))
        } catch {
            completion?(.failure(SignOutError()))
        }
    }
    
}

public extension Authentication {
    
    struct SignUpError: Error {
        let localizedDescription = "Unknown error occured during sign up"
    }
    
    struct SignInError: Error {
        let localizedDescription = "Unknown error occured during sign in"
    }
    
    struct SignOutError: Error {
        let localizedDescription = "Unable to log out"
    }
    
}
