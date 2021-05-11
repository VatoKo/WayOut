//
//  ViewController.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 05.05.21.
//

import UIKit
import Core

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        Authentication.shared.signUp(
//            user: SignUpUserData(
//                email: "j.doe@gmail.com",
//                password: "12345678",
//                name: "Jon",
//                surname: "Doe",
//                phoneNumber: "555666777",
//                numberPlate: "JO-001-HN"
//            )
//        ) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let user):
//                    print(user)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
        
        
//        Authentication.shared.signUp(
//            organization: SignUpOrganizationData(
//                email: "freeuni@gmail.com",
//                password: "12345678",
//                name: "Free University of Tbilisi"
//            )
//        ) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let organization):
//                    print(organization)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
        
        Authentication.shared.signIn(user: SignInUserData(email: "kostava.vato@gmail.com", password: "12345678")) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print(user)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

