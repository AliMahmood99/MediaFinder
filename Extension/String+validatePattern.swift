//
//  String+validatePattern.swift
//  MediaFinder
//
//  Created by ali mahmood saad on 6/8/20.
//  Copyright © 2020 ali mahmood. All rights reserved.
//

import UIKit

extension String {
    
    enum Regex :String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@!%*?&#])[A-Za-z\\d$@!%*?&#]{8,10}"
        case phone = "(0)+([0-9]{10})"
        
    }
    
    enum ValidateType {
        case email
        case password
        case phone
    }
    
    func isValid (_ ValidateType :ValidateType) -> Bool {
        
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch ValidateType {
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        case .phone:
            regex = Regex.phone.rawValue
            
        }
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}

