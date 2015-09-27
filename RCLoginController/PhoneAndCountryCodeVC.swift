//
//  PhoneAndCountryCodeVC.swift
//  ES_UIPresentationController_Demo
//
//  Created by Reid Chatham on 9/8/15.
//  Copyright (c) 2015 com.strohtennis. All rights reserved.
//

import UIKit


class PhoneAndCountryCodeVC : ESModalViewController {
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var countryCodeTextField: UITextField!
    
    
    var loginController = LoginController() {
        didSet {
            
        }
    }
    
    
    convenience init(){
        self.init(nibName: "PhoneAndCountryCodeVC", bundle: nil)
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
    
    @IBAction func goToTwoFVerificationVC(sender: AnyObject) {
        
        if phoneNumberTextField.text != nil && !phoneNumberTextField.text!.isEmpty {
            if let countryCode = Int(countryCodeTextField.text!) {
                loginController.didEnter(phoneNumber: phoneNumberTextField.text!, withCountryCode: countryCode)
                
                
                let verificationVC = VerificationVC()
                verificationVC.loginController = loginController
                
                navigationController?.pushViewController(verificationVC, animated: true)
            }
        }
    }
    @IBAction func cancelButtonPressed(sender: UIButton) {
        ESPresentationManager.sharedInstance.presentationController?.dismissModal()
    }
}