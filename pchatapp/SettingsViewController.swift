//
//  SettingsViewController.swift
//  pchatapp
//
//  Created by Cory Barton on 8/27/18.
//  Copyright © 2018 Cory Barton. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var photoUpdate: UIButton!
    
    
    var selectedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        displayName.text = selectedUser?.username
        photoUpdate.setTitle(RemoteConfigManager.remoteConfigValues["PhotoButtonUpdate"], for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getPhotoButton_click(_ sender: Any) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(image, animated: true, completion: nil)
        
    }
    
    @IBAction func uploadButton_click(_ sender: AnyObject) {
        
        uploadPhoto()
        
    }
    
    func uploadPhoto() {
        
        selectedUser?.uploadProfilePhoto(profileImage: imageView.image!)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickerInfo: NSDictionary = info as NSDictionary
        let img: UIImage = pickerInfo.object(forKey: UIImagePickerController.InfoKey.originalImage) as! UIImage
        imageView.image = img
        self.dismiss(animated: true, completion: nil)
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
