//
//  RCLoginVC.swift
//  RCLoginController
//
//  Created by Reid Chatham on 10/9/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import UIKit

public class RCLoginVC: UIViewController {
    
    
    var loginController = RCLoginController()
    
    var user : RCUser?
    
    

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if user == nil {
            loginController.loadFromSaved() {
                [weak self]
                (user: RCUser?) in
                self?.user = user
            }
            print("Verified: \(user?.phoneVerified)")
        }
    }
    
    // viewDidAppear
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Must update this if statement when checking for verification
        if user?.phoneVerified == true {
            
        } else {
            
        }
    }
    
    
    let detailTransitioningDelegate: ESPresentationManager = ESPresentationManager.sharedInstance

    public func presentLoginInNavigation(authyAPIKey authyAPIKey : String, loginColor: UIColor = UIColor.lightGrayColor()) {
        let innerViewController = PhoneAndCountryCodeVC()
        innerViewController.loginController = RCLoginController(authyAPIKey: authyAPIKey)
        innerViewController.view.backgroundColor = loginColor
        
        let navCtl = ESModalNavigationController(rootViewController: innerViewController)
        navCtl.modalPresentationStyle = UIModalPresentationStyle.Custom
        navCtl.transitioningDelegate = detailTransitioningDelegate
        navCtl.setNavigationBarHidden(true, animated: false)
        presentViewController(navCtl, animated: true, completion: nil)
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
