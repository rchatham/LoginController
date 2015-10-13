//
//  CreateProfileVC.swift
//  ES_UIPresentationController_Demo
//
//  Created by Reid Chatham on 9/8/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import UIKit


public class CreateProfileVC : ESModalViewController, UITextFieldDelegate {
    
    
    var user : RCUser? {
        didSet {
            print("The user has landed: \(user)")
        }
    }
    
    
    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet {
            firstNameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var lastNameTextField: UITextField! {
        didSet {
            lastNameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.layer.cornerRadius = imageView.frame.size.width/2
            imageView.clipsToBounds = true
        }
    }
    
    convenience public init(){
        let frameworkBundle = NSBundle(forClass: self.dynamicType)
        self.init(nibName: "CreateProfileVC", bundle: frameworkBundle)
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
    
    // Text field methods
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        return true
    }
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func goToNextVC(sender: UIButton) {
        
        user?.firstName = firstNameTextField.text
        user?.lastName = lastNameTextField.text
        
        (ESPresentationManager.sharedInstance.presentationController?.presentingViewController as! RCLoginVC).user = user
        
        ESPresentationManager.sharedInstance.presentationController?.dismissModal()
        
    }
    
    @IBAction func goBack(sender: UIButton) {
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    
}