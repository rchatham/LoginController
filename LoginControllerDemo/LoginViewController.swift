//
//  LoginViewController.swift
//  LoginController
//
//  Created by Reid Chatham on 10/9/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import UIKit
import LoginController

public class LoginViewController<T : Loggable> : UIViewController, LoginPresenter {
    
    public var user : T?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if user == nil {
            LoginController.loadFromSaved() {
                [weak self]
                (user: T?) in
                self?.user = user
            }
        }
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Check if current user is verified
        guard let verified = user?.phoneVerified where verified == true
            else { return (user = nil) }
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func presentLoginInNavigation(authyAPIKey authyAPIKey: String, loginColor: UIColor, existingUserCheck: ((T, (Bool) -> Void) -> Void)?) {
        
        presentLoginInNavigation(fromViewController: self, authyAPIKey: authyAPIKey, loginColor: loginColor, existingUserCheck: existingUserCheck)
    }
    
    internal func setUserFromLoggable(login: Loggable) {
        guard let user = login as? T else { return }
        self.user = user
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
