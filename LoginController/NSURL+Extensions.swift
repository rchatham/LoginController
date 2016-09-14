//
//  NSURL+Extensions.swift
//  LoginController
//
//  Created by Reid Chatham on 9/13/16.
//  Copyright © 2016 Hermes Messenger LLC. All rights reserved.
//

import Foundation

extension NSURL {
    
    static func documentsDirectory() -> NSURL {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        return NSURL(string: documentsFolderPath)!
    }
    
    static func fileInDocumentsDirectory(filename: String) -> NSURL {
        return documentsDirectory().URLByAppendingPathComponent(filename)
    }
}

