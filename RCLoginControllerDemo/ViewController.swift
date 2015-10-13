//
//  ViewController.swift
//  RCLoginControllerDemo
//
//  Created by Reid Chatham on 9/26/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import UIKit


class ViewController: RCLoginVC { // Subclass RCLoginVC then implement presentLoginNavigation
    
    override var user : RCUser? {
        didSet {
            if self.userStatusLabel != nil && user != nil {
                self.userStatusLabel.text = "User Logged In!"
            }
        }
    }
    
    var loginColor = UIColor(red: 253/255, green: 149/255, blue: 112/255, alpha: 1)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // viewDidAppear
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func loginPressed(sender: UIButton) {
        // Implement presentLoginNavigation
        presentLoginInNavigation(authyAPIKey: "X3FQn6Gliy0TzDCJxqbfGrydzzYylcmy", loginColor: loginColor)
    }
    
    @IBOutlet weak var userStatusLabel: UILabel!
    

}

