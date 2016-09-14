//
//  Login.swift
//  LoginController
//
//  Created by Reid Chatham on 9/26/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import Foundation

public class Login {
    
    let phoneNumber: String
    let countryCode: Int
    var email: String?
    var authID = NSNumber(integer: 0)
    var token: String = ""
    var phoneVerified = false
    
    init(phoneNumber: String, countryCode: Int) {
        self.phoneNumber = phoneNumber
        self.countryCode = countryCode
    }
}