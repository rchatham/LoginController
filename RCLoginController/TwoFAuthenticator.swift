//
//  TwoFAuthenticator.swift
//  TwoFAuthenticator
//
//  Created by Reid Chatham on 9/22/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import UIKit



let kRecievedAuthID = "RecievedAuthID"
let kTokenIsVerfied = "TokenIsVerified"


class TwoFAuthenticator: NSObject {
    
    
    /////////////////////////////////////////
    ////////AUTHY////////////////////////////
    /////////////////////////////////////////
    
    let authyKey : String
    
    /////////////////////////////////////////
    ////////TwoFA FUNCTIONS//////////////////
    /////////////////////////////////////////
   
    init(authyAPIKey: String) {
        self.authyKey = authyAPIKey
        super.init()
    }
    
    func CreateNewUser(phoneNumber: String, countryCode: Int, email: String = "user@email.com", completionHandler: (NSNumber -> ())? ) {
        
        
        print("Create New Authy User")
        
        let requestString = "https://api.authy.com/protected/json/users/new?api_key=\(authyKey)"
        
        let requestFromAuthy = NSMutableURLRequest(URL: NSURL(string: requestString)!)
        requestFromAuthy.HTTPMethod = "POST"
        
        
        let newUserPost = ["user": ["cellphone": phoneNumber, "country_code": "\(countryCode)", "email": email]] as NSDictionary
        
        print("\(newUserPost)")
        
        
        requestFromAuthy.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        requestFromAuthy.addValue("278", forHTTPHeaderField: "Content-Length")
        do {
            requestFromAuthy.HTTPBody = try NSJSONSerialization.dataWithJSONObject(newUserPost, options: [])
        } catch let error as NSError {
            print(error)
            requestFromAuthy.HTTPBody = nil
        }
        
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(requestFromAuthy) {
            (data, response, error) in
            
            if error != nil {
                print("POST Error calling to create user: \(error!.description)")
            } else if data != nil {
                
                let user = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSDictionary
                
                //Saving the AuthId that is needed when creating another user and retreiving SMS Tokens
                
                print("The user info is: " + user.description)
                let userObj = user["user"] as! NSDictionary
                let id = userObj["id"] as! NSNumber
                
                print("Auth ID: \(id)")
                
                dispatch_async(dispatch_get_main_queue()) {

                    completionHandler?(id)
                } 
            }
        }
        task.resume()
    }
    
    
    func RequestSMSToken(authID: NSNumber, completionHandler: (Void -> Void)? ) {
        
        print("Request SMS Token")
        
        let requestString = "https://api.authy.com/protected/json/sms/\(authID)?api_key=\(authyKey)&force=true"
        
        let requestFromAuthy = NSMutableURLRequest(URL: NSURL(string: requestString)!)
        requestFromAuthy.HTTPMethod = "GET"
        
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        let task = session.dataTaskWithRequest(requestFromAuthy) {
            (data, response, error) in
            
            if error != nil {
                print("POST Error calling to request SMS token: \(error!.description)")
            } else if data != nil {
                
                let user = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSDictionary
                
                
                print("The sms info is: " + user.description)
                
                let success = user["success"] as! Int
                
                print("\(success)")
                
                if success == 0 {
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        let alert = UIAlertController(title: "OPPS", message: "There was an Error requesting SMS code, please try again later", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default) { (action) -> Void in })
                        let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController
                        rootVC?.presentViewController(alert, animated: true) { () -> Void in}
                        
                        completionHandler?()
                    }
                }
            }
        }
        task.resume()
        
    }
    
    
    func VerifiyTokenEntered(token: String, authID: NSNumber, openingHandler: (UIView -> ())?, completionHandler: ((Bool, UIView) -> ())? ) {
        
        let requestString = "https://api.authy.com/protected/json/verify/\(token)/\(authID)?api_key=\(authyKey)" //&force=true"
        
        let verifyFromAuthy = NSMutableURLRequest(URL: NSURL(string: requestString)!)
        verifyFromAuthy.HTTPMethod = "GET"
        
        let indicator = verifyingView()
        
        openingHandler?(indicator)
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(verifyFromAuthy) {
            (data, response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                var success = false
                
                if error != nil {
                    print("GET Error calling to verify token: \(error!.description)")
                    
                    
                } else if data != nil {
                    
                    let user = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSDictionary
                    
                    print("The verify info is: " + user.description)
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
                    
                }
                
                completionHandler?(success, indicator)
                
            }
            
        }
        task.resume()
        
    }
    
    func verifyingView () -> UIView {
        
        let boxView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50, height: 50))
        boxView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.5)
        boxView.opaque = false
        boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()
        
        boxView.addSubview(activityView)
        
//        view.addSubview(boxView)
        
        boxView.hidden = true
        
        return boxView
    }
    
}
