//
//  RemoteConfigManager.swift
//  pchatapp
//
//  Created by Cory Barton on 8/31/18.
//  Copyright © 2018 Cory Barton. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig

class RemoteConfigManager: NSObject {
    
    static let interval: TimeInterval = 10
    static var remoteConfigValues:[String:String] = [:]
    static var controlsToUpdate:[String:NSObject] = [:]
    
    static func remoteConfigInit(firstControl: UIButton) {
        
        RemoteConfigManager.controlsToUpdate["loginButton"] = firstControl
        
        let remoteValues = RemoteConfig.remoteConfig()
        RemoteConfigManager.remoteConfigValues["loginButton"] = remoteValues["loginButton"].stringValue
        RemoteConfigManager.remoteConfigValues["PhotoButtonUpdate"] = remoteValues["PhotoButtonUpdate"].stringValue
        
        let remoteConfigDefaults:[String:String] = [
            "loginButton":("login" as NSObject) as! String,
            "PhotoButtonUpdate":("update" as NSObject) as! String
        ]
        RemoteConfig.remoteConfig().setDefaults(remoteConfigDefaults as [String : NSObject])
        
        //43200 = 12 hours
        Timer.scheduledTimer(timeInterval: RemoteConfigManager.interval, target: self, selector: #selector(RemoteConfigManager.startFetching(firstControl:)), userInfo: nil, repeats: true)
        
        remoteConfigDebugMode()
        startFetching(firstControl: firstControl)
        
        
    }
    
    @objc static func startFetching(firstControl:UIButton) {
        
        let remoteValues = RemoteConfig.remoteConfig()
        RemoteConfigManager.remoteConfigValues["loginButton"] = remoteValues["loginButton"].stringValue
        RemoteConfigManager.remoteConfigValues["PhotoButtonUpdate"] = remoteValues["PhotoButtonUpdate"].stringValue
        
        
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: RemoteConfigManager.interval) {
            (status, error) in
            guard error == nil else {
                print("Error fetching remote config values \(error)")
                return
            }
            RemoteConfig.remoteConfig().activateFetched()
            let fc = RemoteConfigManager.controlsToUpdate["loginButton"] as! UIButton
            print("loginButton value: \(RemoteConfigManager.remoteConfigValues["loginButton"])")
            fc.setTitle(RemoteConfigManager.remoteConfigValues["loginButton"], for: .normal)
        }
    }
    
    static func remoteConfigDebugMode() {
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings
    }
    
}
