//
//  ViewController.swift
//  pchatapp
//
//  Created by Cory Barton on 8/27/18.
//  Copyright © 2018 Cory Barton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func loginButton_click(_ sender: Any) {
        //let email = "test1@gmail.com"
        //let password = "openopen"
        FirebaseManager.Login(email: email.text!, password: password.text!) { (success:Bool) in
            if(success){
                self.performSegue(withIdentifier: "showProfile", sender: sender)
            }
        }
    }
    
    @IBAction func createAccountButton_click(_ sender: Any) {
        
        FirebaseManager.createAccount(email: email.text!, password: password.text!, username: username.text!) {
            (result: String) in

            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showProfile", sender: sender)
            }
            
        }
        
    }
    
}
