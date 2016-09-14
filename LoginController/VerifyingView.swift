//
//  VerifyingView.swift
//  LoginController
//
//  Created by Reid Chatham on 11/20/15.
//  Copyright © 2015 Hermes Messenger LLC. All rights reserved.
//

import UIKit

class VerifyingView: UIView {

    var activityView: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
        setup()
    }
    
    func setup() {
        
        self.frame = CGRect(x: 0.0, y: 0.0, width: 50, height: 50)
        self.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.5)
        self.opaque = false
        self.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()
        
        self.addSubview(activityView)
        self.hidden = true
    }
    
    func stopAnimating() {
        activityView.stopAnimating()
    }
    
    func startAnimating() {
        activityView.startAnimating()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
