//
//  VerificationVC.swift
//  ES_UIPresentationController_Demo
//
//  Created by Reid Chatham on 9/8/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import UIKit


public class VerificationViewController<T:Loggable> : ESModalViewController, UITextFieldDelegate  {
    
    
    var loginController : LoginController! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var smsCodeTextField: UITextField! {
        didSet {
            smsCodeTextField.delegate = self
        }
    }
    
    var existingUserCheck: ((T, (Bool) -> Void ) -> Void)?
    
    
    convenience public init(){
        let frameworkBundle = NSBundle(forClass: self.dynamicType)
        self.init(nibName: "VerificationVC", bundle: frameworkBundle)
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ESPresentationManager.sharedInstance.presentationController?.changeSize()
        //preferredContentSize = modalPresentationSize()
    }
    
    override public func modalPresentationSize()->CGSize{
        return CGSizeMake(300, 500)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Text Field methods
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        smsCodeTextField.resignFirstResponder()
        return true
    }
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func goToNextVC(sender: UIButton) {
        
        if smsCodeTextField.text != nil && !smsCodeTextField.text!.isEmpty {
            loginController.didEnter(token: smsCodeTextField.text!, openingHandler: {
                [weak self]
                (verifyingView: UIView) -> Void in
                if self?.view.center != nil {
                    verifyingView.center = self!.view.center
                    self!.view.addSubview(verifyingView)
                    if verifyingView.hidden {
                        verifyingView.hidden = false
                    }
                }
                
            }, completionHandler: {
                [weak self]
                (verifyingView: UIView, user: T?) -> Void in
                
                if self?.view.center != nil {
                    
                    // Check if User already exists on server or if needs to be created
                    
                    if let user = user, userCheck = self?.existingUserCheck {
                        userCheck(user) { [weak self] exists in
                            
                            if !verifyingView.hidden {
                                verifyingView.hidden = true
                            }
                                
                            if exists {
                                print("User exists on server")
                                (ESPresentationManager.sharedInstance.presentationController?.presentingViewController as! LoginViewController).user = user
                                ESPresentationManager.sharedInstance.presentationController?.dismissModal()
                            } else {
                                print("Should create user")
                                self?.shouldCreateUser(user)
                            }
                        }
                    } else if user != nil {
                        if !verifyingView.hidden {
                            verifyingView.hidden = true
                        }
                        print("Should create user")
                        self?.shouldCreateUser(user!)
                    } else {
                        print("User not verified")
                    }
                }
            })
        }
    }
    
    func shouldCreateUser(user: T) {
        
        let nextVC = CreateProfileViewController<T>()
        nextVC.user = user
        nextVC.view.backgroundColor = self.view.backgroundColor
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func goBack(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    
}