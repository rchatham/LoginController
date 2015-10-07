//
//  ViewController.swift
//  RCLoginController
//
//  Created by Reid Chatham on 9/26/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import UIKit




func documentsDirectory() -> NSURL {
    let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
    return NSURL(string: documentsFolderPath)!
}

func fileInDocumentsDirectory(filename: String) -> String {
    return documentsDirectory().URLByAppendingPathComponent(filename).path!
}



class ViewController: UIViewController {

    
    var loginController = LoginController()
    
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if user == nil {
            loginController.loadFromSaved() {
                [weak self]
                (user: User) in
                self?.user = user
            }
            print("Verified: \(user!.phoneVerified)")
        }
    }
    
    // viewDidAppear
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //Must update this if statement when checking for verification
        if user?.phoneVerified == true {   //profile!.authID != 0 && profile?.token != 0 && profile!.userID != nil {
            
        } else {
            
        }
    }
    
    
    let detailTransitioningDelegate: ESPresentationManager = ESPresentationManager.sharedInstance

    @IBAction func loginPressed(sender: UIButton) {
        let innerViewController = PhoneAndCountryCodeVC()
        innerViewController.loginController = loginController
        
        let navCtl = ESModalNavigationController(rootViewController: innerViewController)
        navCtl.modalPresentationStyle = UIModalPresentationStyle.Custom
        navCtl.transitioningDelegate = detailTransitioningDelegate
        navCtl.setNavigationBarHidden(true, animated: false)
        presentViewController(navCtl, animated: true, completion: nil)
    }

}

