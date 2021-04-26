//
//  StringExtensions.swift
//  Free Bank
//
//  Created by Sasha Zontova on 4/27/21.
//

import UIKit

extension String {
    func isPasswordValidate() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,50}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    func isEmailValidate() -> Bool {
        let pattern = "[A-Z0-9a-z._]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
    }
    
    func isLoginValidate() -> Bool {
        let pattern = "^[0-9a-zA-Z_.]{8,30}"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
    }
}
