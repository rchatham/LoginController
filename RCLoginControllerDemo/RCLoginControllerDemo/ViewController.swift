//
//  ViewController.swift
//  RCLoginControllerDemo
//
//  Created by Reid Chatham on 10/12/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import UIKit
import RCLoginController

class ViewController: RCLoginVC { // Subclass RCLoginVC then implement presentLoginNavigation

    override var user : RCUser? {
        didSet {
            if self.userStatusLabel != nil && user != nil {
                self.userStatusLabel.text = "User Logged In!"
            }
        }
    }
    
    var loginColor = UIColor(red: 253/255, green: 149/255, blue: 112/255, alpha: 1)
    
    func checkServerForUser(user: RCUser) -> (Bool, RCUser) {
        return (true, user)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logginPressed(sender: UIButton) {
        // Implement presentLoginNavigation
//        presentLoginInNavigation(authyAPIKey: "YourAuthyAPIKey")
//        presentLoginInNavigation(authyAPIKey: "YourAuthyAPIKey", loginColor: loginColor)
        
        presentLoginInNavigation(authyAPIKey: "YourAuthyAPIKey", loginColor: loginColor) {
            [weak self]
            (user, completion) in
            
            print("Should check server for user")
            
            if let result = self?.checkServerForUser(user) {
                
                completion(result)
            }
            
        }
    }
    
    @IBOutlet weak var userStatusLabel: UILabel!
    

}

