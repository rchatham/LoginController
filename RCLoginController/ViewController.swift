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

    let detailTransitioningDelegate: ESPresentationManager = ESPresentationManager.sharedInstance

    @IBAction func loginPressed(sender: UIButton) {
        let innerViewController = PhoneAndCountryCodeVC()
        let navCtl = ESModalNavigationController(rootViewController: innerViewController)
        navCtl.modalPresentationStyle = UIModalPresentationStyle.Custom
        navCtl.transitioningDelegate = detailTransitioningDelegate
        navCtl.setNavigationBarHidden(true, animated: false)
        presentViewController(navCtl, animated: true, completion: nil)
    }

}

