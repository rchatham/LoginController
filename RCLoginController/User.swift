//
//  User.swift
//  RCLoginController
//
//  Created by Reid Chatham on 9/27/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import Foundation


class User : Loggable {
    
    required init() {
        
    }
    required init(phoneNumber: String, countryCode: Int) {
        self.phoneNumber = phoneNumber
        self.countryCode = countryCode
    }
    
    
    var phoneNumber = ""
    var countryCode = 0
    var phoneVerified = false
    var savePath : String {
        return fileInDocumentsDirectory("user.plist")
    }
    
}