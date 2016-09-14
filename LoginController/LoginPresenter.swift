//
//  LoginPresenter.swift
//  LoginController
//
//  Created by Reid Chatham on 9/13/16.
//  Copyright © 2016 Hermes Messenger LLC. All rights reserved.
//

import UIKit

public protocol LoginPresenter {
    
    var detailTransitioningDelegate: ESPresentationManager { get }
    
    func presentLoginInNavigation<T:Loggable>(fromViewController viewController: UIViewController, authyAPIKey: String, loginColor: UIColor, existingUserCheck: ((T, (Bool) -> Void) -> Void)?)
}

extension LoginPresenter {
    
    public var detailTransitioningDelegate: ESPresentationManager {
        return ESPresentationManager.sharedInstance
    }
    
    public func presentLoginInNavigation<T:Loggable>(fromViewController viewController: UIViewController, authyAPIKey: String, loginColor: UIColor = UIColor.lightGrayColor(), existingUserCheck: ((T, (Bool) -> Void) -> Void)? = nil) {
        
        let innerViewController = PhoneAndCountryCodeViewController<T>()
        innerViewController.loginController = LoginController(authyAPIKey: authyAPIKey)
        innerViewController.view.backgroundColor = loginColor
        innerViewController.existingUserCheck = existingUserCheck
        
        let navCtl = ESModalNavigationController(rootViewController: innerViewController)
        navCtl.modalPresentationStyle = UIModalPresentationStyle.Custom
        navCtl.transitioningDelegate = detailTransitioningDelegate
        navCtl.setNavigationBarHidden(true, animated: false)
        viewController.presentViewController(navCtl, animated: true, completion: nil)
    }
}
