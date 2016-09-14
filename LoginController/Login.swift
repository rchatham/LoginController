//
//  Login.swift
//  LoginController
//
//  Created by Reid Chatham on 9/26/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import Foundation


public protocol Loggable {
    
    init(phoneNumber: String, countryCode: Int)
    
    var phoneNumber : String { get }
    var countryCode : Int { get }
    
    var email : String? { get set }
    
    var firstName : String? { get set }
    var lastName : String? { get set }
    
    var phoneVerified : Bool { get set }
    
    static var savePath : String { get }
}

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