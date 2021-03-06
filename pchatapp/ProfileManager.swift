//
//  ProfileManager.swift
//  pchatapp
//
//  Created by Cory Barton on 8/28/18.
//  Copyright © 2018 Cory Barton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ProfileManager: NSObject {
    
    static let databaseRef = Database.database().reference()
    static let uid = Auth.auth().currentUser?.uid
    
    static var users = [User]()
    
    static func getCurrentUser(uid:String) -> User? {
        if let i = users.index(where: {$0.uid == uid}){
            return users[i]
        }
        return nil
    }
    
    static func fillUsers(completion: @escaping () -> Void) {
        users = []
        databaseRef.child("users").observe(.childAdded, with: {
            snapshot in
            print(snapshot)
            if let result = snapshot.value as? [String:AnyObject]{
                let uid = result["uid"]! as! String
                let username = result["username"]! as! String
                let email = result["email"]! as! String
                let profileImageUrl = result["profileImageUrl"]! as! String
                
                let u = User(uid: uid, username: username, email: email, profileImageUrl: profileImageUrl)
                
                ProfileManager.users.append(u)
            }
            completion()
        })
    }
    
}
