//
//  DatabaseAccessible.swift
//  Core
//
//  Created by Vakhtang Kostava on 08.06.21.
//

import Foundation
import Firebase

protocol DatabaseAccessible {
    var databaseReference: DatabaseReference! { get }
}

extension DatabaseAccessible {
    
    var databaseReference: DatabaseReference! {
        return Database.database(url: "https://wayout-94da9-default-rtdb.europe-west1.firebasedatabase.app").reference()
    }
    
}
