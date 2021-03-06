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
    
    static func createAccount(email: String, password: String, username: String, completion: @ escaping(_ result: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error)
            in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            AddUser(username: username, email: email)
            Login(email: email, password: password) {
                (success: Bool) in
                if(success) {
                    print("Login successful after account creation")
                } else {
                    print("Login unsuccesful after account creation")
                }
            }
            completion("")
        })
    }
    
    static func AddUser(username: String, email: String) {
        let uid = Auth.auth().currentUser?.uid
        let post = ["uid":uid!, "username":username, "email":email, "profileImageUrl":""]
        databaseRef.child("users").child(uid!).setValue(post)
    }
    
}
