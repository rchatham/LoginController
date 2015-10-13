//
//  VerificationVC.swift
//  ES_UIPresentationController_Demo
//
//  Created by Reid Chatham on 9/8/15.
//  Copyright (c) 2015 com.strohtennis. All rights reserved.
//

import UIKit


class VerificationVC : ESModalViewController, UITextFieldDelegate  {
    
    
    var loginController : RCLoginController! {
        didSet {
            
        }
    }
    
    
    
    @IBOutlet weak var smsCodeTextField: UITextField! {
        didSet {
            smsCodeTextField.delegate = self
        }
    }
    
    
    convenience init(){
        self.init(nibName: "VerificationVC", bundle:nil)
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
        smsCodeTextField.resignFirstResponder()
        return true
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
                (verifyingView: UIView, user: RCUser?) -> Void in
                if self?.view.center != nil {
                    if !verifyingView.hidden {
                        verifyingView.hidden = true
                    }
                        
                    let nextVC = CreateProfileVC()
                    nextVC.user = user
                    nextVC.view.backgroundColor = self?.view.backgroundColor
                    
                    self?.navigationController?.pushViewController(nextVC, animated: true)
                        
                }
            })
        }
        
        
    }
    
    @IBAction func goBack(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    
}