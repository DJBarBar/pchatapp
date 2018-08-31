//
//  User.swift
//  pchatapp
//
//  Created by Cory Barton on 8/28/18.
//  Copyright © 2018 Cory Barton. All rights reserved.
//

import UIKit
import FirebaseStorage

class User: NSObject {
    var username:String
    var email:String
    var uid:String
    var profileImageUrl:String
    
    init(uid:String, username:String, email:String, profileImageUrl:String){
        self.uid = uid
        self.username = username
        self.email = email
        self.profileImageUrl = profileImageUrl
    }
    
    func getProfileImage() -> UIImage {
        
        if let url = NSURL(string: profileImageUrl) {
            if let data = NSData(contentsOf: url as URL) {
                return UIImage(data: data as Data)!
            }
        }
        return UIImage()
    }
    
    func uploadProfilePhoto(profileImage: UIImage) {
        let profileImageRef = Storage.storage().reference().child("profileImage").child("\(NSUUID().uuidString).jpg")
        if let imageData = profileImage.jpegData(compressionQuality: 0.25) {
            profileImageRef.putData(imageData, metadata: nil) {
                metadata, error in
                if error != nil {
                    print(error)
                    return
                } else {
                    print(metadata)
                    profileImageRef.downloadURL(completion: { (url, error) in
                        if (self.profileImageUrl == "") {
                            if let urlString = url?.absoluteString {
                                self.profileImageUrl = urlString
                            }
                            FirebaseManager.databaseRef.child("users").child(self.uid).updateChildValues(["profileImageUrl": url])
                        }
                    })
                    
                }
            }
        }
    }
    
}
