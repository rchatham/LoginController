//
//  LoginViewController.swift
//  LoginController
//
//  Created by Reid Chatham on 10/9/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import UIKit

public class LoginViewController<T : Loggable> : UIViewController, LoginPresenter {
    
    public var user : T?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if user == nil {
            LoginController.loadFromSaved() {
                [weak self]
                (user: T?) in
                self?.user = user
            }
            print("Verified: \(user?.phoneVerified)")
        }
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Must update this if statement when checking for verification
        if user?.phoneVerified == true {
            
        } else {
            
        }
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
