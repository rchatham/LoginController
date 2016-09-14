//
//  LoginController.swift
//  LoginController
//
//  Created by Reid Chatham on 9/26/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import UIKit

public protocol LoginControllerDelegate: class {
    func loginControllerFailedToLogin()
}

public class LoginController {
    
    public weak var delegate : LoginControllerDelegate?
    
    private var authyAPIKey : String!
    private var login : Login?
    private lazy var twoFA : TwoFAuthenticator = { [unowned self] in
        return TwoFAuthenticator(authyAPIKey: self.authyAPIKey)
    }()
    
    public init(authyAPIKey : String) {
        self.authyAPIKey = authyAPIKey
    }
    
    public func didEnter(phoneNumber phoneNumber: String, withCountryCode countrycode: Int, completion: (Void -> ())? = nil ) {
        login = Login(phoneNumber: phoneNumber, countryCode: countrycode)
        twoFA.createNewUser(phoneNumber, countryCode: countrycode) {
            [weak self]
            (authID) -> () in
            self?.didRecieve(authID: authID)
            completion?()
        }
    }
    
    public func didEnter(phoneNumber phoneNumber: String, withCountryCode countrycode: Int, andEmail email: String, completion: (Void -> ())? = nil ) {
        login = Login(phoneNumber: phoneNumber, countryCode: countrycode)
        login!.email = email
        twoFA.createNewUser(phoneNumber, countryCode: countrycode, email: email) {
            [weak self]
            (authID) -> () in
            self?.didRecieve(authID: authID)
            completion?()
        }
    }
    
    public func didRecieve(authID authID: NSNumber) {
        login!.authID = authID
        twoFA.requestSMSToken(authID, completionHandler: nil)
    }
    
    public func didEnter<T : Loggable>(token token: String, openingHandler: (UIView -> Void)?, completionHandler: ((UIView, T?) -> Void)? ) {
        login!.token = token
        twoFA.verifiyTokenEntered(token, authID: login!.authID, openingHandler: openingHandler) {
            [weak self]
            (success, verifyingView) -> () in
            self?.login?.phoneVerified = success
            if success {
                completionHandler?(verifyingView, self?.shouldLogin())
            } else {
                self?.loginFailed()
                completionHandler?(verifyingView, nil)
            }
        }
    }
    
    public func shouldLogin<T : Loggable>() -> T? {
        
        var loggable = T(phoneNumber: login!.phoneNumber, countryCode: login!.countryCode)
        loggable = LoginController.loadFromSaved(loggable)
        loggable.phoneVerified = login!.phoneVerified
        return loggable
    }
    
    public func loginFailed() {
        //Present to user failed attempt
        delegate?.loginControllerFailedToLogin()
    }
    
    public static func loadFromSaved<T : Loggable>(type: T) -> T {
        //Do on background thread
        
        if let load : T = loadFromSaved(fromPath: T.savePath) {
            if type.phoneNumber == load.phoneNumber {
                return load
            } else {
                return type
            }
        } else {
            return type
        }
    }
    
    public static func loadFromSaved<T : Loggable>(completion: (T?->())? ){
        //Do on background thread
        
        if let load : T = loadFromSaved(fromPath: T.savePath) {
            completion?(load)
        } else {
            completion?(nil)
        }
    }
    
    public static func loadFromSaved<T : Loggable>(fromPath path: String) -> T? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? T
    }
}