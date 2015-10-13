//
//  RCLoginController.swift
//  RCLoginController
//
//  Created by Reid Chatham on 9/26/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import UIKit

protocol Loggable { //@objc if you want optional email
    
    init()
    init(phoneNumber: String, countryCode: Int)
    
    var phoneNumber : String { get set }
    var countryCode : Int { get set }
//    optional var email : String { get set }
    var phoneVerified : Bool { get set }
    var savePath : String { get }
    
}

class RCLoginController {
    
    private var authyAPIKey : String!
    
    private var login = RCLogin()
    
    private lazy var twoFA : TwoFAuthenticator = {
        [unowned self] in
        return TwoFAuthenticator(authyAPIKey: self.authyAPIKey)
        }()
    
    
    
    init() {}
    init(authyAPIKey : String) {
        self.authyAPIKey = authyAPIKey
    }
    
    
    
    func didEnter(phoneNumber phoneNumber: String, withCountryCode countrycode: Int) {
        didEnter(phoneNumber: phoneNumber, withCountryCode: countrycode, completion: nil)
    }

    
    func didEnter(phoneNumber phoneNumber: String, withCountryCode countrycode: Int, completion: (Void -> ())? ) {
        login.phoneNumber = phoneNumber
        login.countryCode = countrycode
        twoFA.CreateNewUser(phoneNumber, countryCode: countrycode) {
            [weak self]
            (authID) -> () in
            self?.didRecieve(authID: authID)
            completion?()
        }
    }
    
    func didEnter(phoneNumber phoneNumber: String, withCountryCode countrycode: Int, andEmail email: String) {
        didEnter(phoneNumber: phoneNumber, withCountryCode: countrycode, andEmail: email, completion: nil)
    }
    
    func didEnter(phoneNumber phoneNumber: String, withCountryCode countrycode: Int, andEmail email: String, completion: (Void -> ())? ) {
        login.phoneNumber = phoneNumber
        login.countryCode = countrycode
        login.email = email
        twoFA.CreateNewUser(phoneNumber, countryCode: countrycode, email: email) {
            [weak self]
            (authID) -> () in
            self?.didRecieve(authID: authID)
            completion?()
        }
    }
    
    func didRecieve(authID authID: NSNumber) {
        login.authID = authID
        twoFA.RequestSMSToken(authID, completionHandler: nil)
    }
    
    func didEnter<T : Loggable>(token token: String, openingHandler: (UIView -> Void)?, completionHandler: ((UIView, T?) -> Void)? ) {
        login.token = token
        twoFA.VerifiyTokenEntered(token, authID: login.authID, openingHandler: openingHandler) {
            [weak self]
            (success, verifyingView) -> () in
            self?.login.phoneVerified = success
            if success {
                completionHandler?(verifyingView, self?.shouldLogin())
            } else {
                self?.loginFailed()
                completionHandler?(verifyingView, nil)
            }
        }
    }
    
    func shouldLogin<T : Loggable>() -> T? {
        
        var loggable = T(phoneNumber: login.phoneNumber!, countryCode: login.countryCode!)
        loggable.phoneVerified = login.phoneVerified
        loggable = loadFromSaved(ofType: loggable)
        return loggable
    }
    
    func loginFailed() {
        //Present to user failed attempt
    }
    
    func loadFromSaved<T : Loggable>(ofType type: T) -> T {
        //Do on background thread
        
        if let load : T = loadFromSaved(fromPath: type.savePath) {
            if type.phoneNumber == load.phoneNumber {
                return load
            } else {
                return type
            }
        } else {
            return type
        }
    }
    
    func loadFromSaved<T : Loggable>(completion: (T?->())? ){
        //Do on background thread
        
        if let load : T = loadFromSaved(fromPath: T().savePath) {
            completion?(load)
        } else {
            completion?(nil)
        }
    }
    
    func loadFromSaved<T : Loggable>(fromPath path: String) -> T? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? T
    }
    
    
    
}