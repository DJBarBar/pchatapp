//
//  ChatViewController.swift
//  pchatapp
//
//  Created by Cory Barton on 8/27/18.
//  Copyright © 2018 Cory Barton. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedUser: User?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PostManager.fillPosts(uid: FirebaseManager.currentUser?.uid, toId:(selectedUser?.uid)!) {  (result:String) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        PostManager.posts = []
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PostManager.posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! chatTableViewCell
        //let messageText = cell.messageText!
        //messageText.delegate = self
        let post = PostManager.posts[indexPath.row]
        cell.messageText.text = post.text
        
        return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

extension ChatViewController:UITextViewDelegate {
    
}
