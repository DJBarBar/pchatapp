//
//  FirebaseManager.swift
//  pchatapp
//
//  Created by Cory Barton on 8/27/18.
//  Copyright © 2018 Cory Barton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FirebaseManager: NSObject {
    static let databaseRef = Database.database().reference()
    static var currentUserId: String = ""
    static var currentUser: Firebase.User? = nil
    
    static func Login(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                currentUser = user?.user
                currentUserId = (user?.user.uid)!
                completion(true) }
        })
    }
}