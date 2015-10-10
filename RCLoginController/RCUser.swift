//
//  User.swift
//  RCLoginController
//
//  Created by Reid Chatham on 9/27/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import Foundation

func documentsDirectory() -> NSURL {
    let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
    return NSURL(string: documentsFolderPath)!
}

func fileInDocumentsDirectory(filename: String) -> String {
    return documentsDirectory().URLByAppendingPathComponent(filename).path!
}


class RCUser : Loggable {
    
    var phoneNumber = ""
    var countryCode = 0
    var phoneVerified = false
    var firstName : String?
    var lastName : String?
    
    var savePath : String { return fileInDocumentsDirectory("user.plist") }
    
    required init() {
        
    }
    
    required init(phoneNumber: String, countryCode: Int) {
        self.phoneNumber = phoneNumber
        self.countryCode = countryCode
    }
    
    
    
}