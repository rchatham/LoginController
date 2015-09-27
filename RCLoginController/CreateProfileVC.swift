//
//  CreateProfileVC.swift
//  ES_UIPresentationController_Demo
//
//  Created by Reid Chatham on 9/8/15.
//  Copyright (c) 2015 com.strohtennis. All rights reserved.
//

import UIKit


class CreateProfileVC : ESModalViewController {
    
    @IBOutlet weak var smsCodeTextField: UITextField!
    
    var user : User? {
        didSet {
            print("The user has landed: \(user)")
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
    
    @IBAction func goToNextVC(sender: UIButton) {
        
        
    }
    
    @IBAction func goBack(sender: UIButton) {
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    
}