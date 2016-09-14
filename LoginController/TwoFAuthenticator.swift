//
//  TwoFAuthenticator.swift
//  TwoFAuthenticator
//
//  Created by Reid Chatham on 9/22/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import UIKit

public class TwoFAuthenticator: NSObject {
    
    let authyKey : String
   
    public init(authyAPIKey: String) {
        self.authyKey = authyAPIKey
        super.init()
    }
    
    public func createNewUser(phoneNumber: String, countryCode: Int, email: String = "user@email.com", completionHandler: (NSNumber -> ())? ) {
        
        let requestString = "https://api.authy.com/protected/json/users/new?api_key=\(authyKey)"
        let requestFromAuthy = NSMutableURLRequest(URL: NSURL(string: requestString)!)
        requestFromAuthy.HTTPMethod = "POST"
        
        
        let newUserPost = ["user": ["cellphone": phoneNumber, "country_code": "\(countryCode)", "email": email]] as NSDictionary
        
        requestFromAuthy.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        requestFromAuthy.addValue("278", forHTTPHeaderField: "Content-Length")
        do {
            requestFromAuthy.HTTPBody = try NSJSONSerialization.dataWithJSONObject(newUserPost, options: [])
        } catch let error as NSError {
            print(error)
            requestFromAuthy.HTTPBody = nil
        }
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        session.dataTaskWithRequest(requestFromAuthy) {
            (data, response, error) in
            
            guard error == nil else {
                print("POST Error calling to create user: \(error!.description)")
                return
            }
            
            guard let data = data, user = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? NSDictionary else { return }
                //Saving the AuthId that is needed when creating another user and retreiving SMS Tokens
                
            print("The user info is: " + user.description)
            
            guard (user["message"] as? String) != "Invalid API key."
                else { fatalError("Authy API key is invalid!") }
            
            let userObj = user["user"] as! NSDictionary
            let id = userObj["id"] as! NSNumber
            
            dispatch_async(dispatch_get_main_queue()) {
                completionHandler?(id)
            }
        }.resume()
    }
    
    public func requestSMSToken(authID: NSNumber, completionHandler: (Void -> Void)? = nil ) {
        
        let requestString = "https://api.authy.com/protected/json/sms/\(authID)?api_key=\(authyKey)&force=true"
        
        let requestFromAuthy = NSMutableURLRequest(URL: NSURL(string: requestString)!)
        requestFromAuthy.HTTPMethod = "GET"
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        session.dataTaskWithRequest(requestFromAuthy) {
            (data, response, error) in
            
            guard error == nil else {
                print("POST Error calling to request SMS token: \(error!.description)")
                return
            }
            
            guard let data = data, user = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? NSDictionary else { return }
            
                
            let success = user["success"] as! Int
                
            if success == 0 {
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    let alert = UIAlertController(title: "OPPS", message: "There was an Error requesting SMS code, please try again later", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { (action) -> Void in })
                    let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController
                    rootVC?.presentViewController(alert, animated: true) { () -> Void in}
                    
                    completionHandler?()
                }
            }
        }.resume()
    }
    
    
    public func verifiyTokenEntered(token: String, authID: NSNumber, openingHandler: (UIView -> ())?, completionHandler: ((Bool, UIView) -> ())? ) {
        
        let requestString = "https://api.authy.com/protected/json/verify/\(token)/\(authID)?api_key=\(authyKey)" //&force=true"
        
        let verifyFromAuthy = NSMutableURLRequest(URL: NSURL(string: requestString)!)
        verifyFromAuthy.HTTPMethod = "GET"
        
        let indicator = VerifyingView()
        
        openingHandler?(indicator)
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        session.dataTaskWithRequest(verifyFromAuthy) {
            (data, response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                var success = false
                
                guard error == nil else {
                    print("GET Error calling to verify token: \(error!.description)")
                    return
                }
                
                guard let data = data, user = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? NSDictionary else { return }
                
                if let successString = user["success"] as? NSString {
                    success = successString.boolValue
                    
                    if success {
                        print("Verified = \(success) on 2FA")
                    } else {
                        let alert = UIAlertController(title: "OPPS", message: "There was an Error. Please Press the Send Again! Button", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default) { (action) -> Void in })
                        let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController
                        rootVC?.presentViewController(alert, animated: true) { () -> Void in }
                    }
                    
                } else if (user["success"] as? Bool != nil) {
                    success = user["success"] as! Bool
                    if success {
                        print("Verified = \(success) on 2FA")
                    } else {
                        let alert = UIAlertController(title: "OPPS", message: "There was an Error. Please Press the Send Again! Button", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default) { (action) -> Void in })
                        let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController
                        rootVC?.presentViewController(alert, animated: true) { () -> Void in }
                    }
                }
                completionHandler?(success, indicator)
            }
        }.resume()
    }
}
