//
//  RCLogin.swift
//  RCLoginController
//
//  Created by Reid Chatham on 9/26/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import Foundation


class RCLogin {
    
    var phoneNumber: String?
    var countryCode: Int?
    var email: String?
    
    var authID = NSNumber(integer: 0)
    var token: String = ""
    
    var phoneVerified = false
    
}