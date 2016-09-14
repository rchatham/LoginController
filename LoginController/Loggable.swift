//
//  Loggable.swift
//  LoginController
//
//  Created by Reid Chatham on 9/14/16.
//  Copyright © 2016 Hermes Messenger LLC. All rights reserved.
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