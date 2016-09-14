//
//  User.swift
//  LoginController
//
//  Created by Reid Chatham on 9/27/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import Foundation

public class User : Loggable {
    
    public let phoneNumber: String
    public let countryCode: Int
    public var email: String? = ""
    public var phoneVerified = false
    public var firstName : String?
    public var lastName : String?
    
    public static var savePath : String {
        return NSURL.fileInDocumentsDirectory("user.plist").path!
    }
    
    required public init(phoneNumber: String, countryCode: Int) {
        self.phoneNumber = phoneNumber
        self.countryCode = countryCode
    }
}