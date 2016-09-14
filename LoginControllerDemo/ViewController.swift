//
//  ViewController.swift
//  LoginControllerDemo
//
//  Created by Reid Chatham on 9/14/16.
//  Copyright © 2016 Hermes Messenger LLC. All rights reserved.
//

import UIKit
import LoginController

class ViewController: LoginViewController<User> {
    
    override var user : User? {
        didSet {
            if user != nil {
                self.userStatusLabel?.text = "User Logged In!"
            }
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    let loginColor = UIColor(red: 253/255, green: 149/255, blue: 112/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userExistsOnServer(user: User) -> Bool {
        return true
    }
    
    @IBAction func logginPressed(sender: UIButton) {
        // Implement presentLoginNavigation

        presentLoginInNavigation(authyAPIKey: "X3FQn6Gliy0TzDCJxqbfGrydzzYylcmy", loginColor: loginColor) {
            [weak self] (user: User, completion) in

            print("Should check server for user")

            guard let result = self?.userExistsOnServer(user) else { return }
            completion(result)
        }
    }

    
    @IBOutlet weak var userStatusLabel: UILabel!
    
}

