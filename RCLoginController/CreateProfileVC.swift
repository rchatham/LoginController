//
//  CreateProfileVC.swift
//  ES_UIPresentationController_Demo
//
//  Created by Reid Chatham on 9/8/15.
//  Copyright (c) 2015 com.strohtennis. All rights reserved.
//

import UIKit


class CreateProfileVC : ESModalViewController, UITextFieldDelegate {
    
    
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
    
    convenience init(){
        self.init(nibName: "CreateProfileVC", bundle:nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ESPresentationManager.sharedInstance.presentationController?.changeSize()
        //preferredContentSize = modalPresentationSize()
    }
    
    override func modalPresentationSize()->CGSize{
        return CGSizeMake(300, 500)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        return true
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