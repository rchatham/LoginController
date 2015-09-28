//
//  VerificationVC.swift
//  ES_UIPresentationController_Demo
//
//  Created by Reid Chatham on 9/8/15.
//  Copyright (c) 2015 com.strohtennis. All rights reserved.
//

import UIKit


class VerificationVC : ESModalViewController {
    
    @IBOutlet weak var smsCodeTextField: UITextField!
    
    
    var loginController = LoginController() {
        didSet {
            
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
                (verifyingView: UIView, user: User?) -> Void in
                if self?.view.center != nil {
                    if !verifyingView.hidden {
                        verifyingView.hidden = true
                    }
                        
                    let nextVC = CreateProfileVC()
                    nextVC.user = user
                    self?.navigationController?.pushViewController(nextVC, animated: true)
                        
                }
            })
        }
        
        
    }
    
    @IBAction func goBack(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    
}