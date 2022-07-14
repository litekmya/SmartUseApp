//
//  Validator.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 13.07.2022.
//

import Foundation

class Validator {
    
    static let shared = Validator()
    
    private init() {}
    
    func check(email: String) -> Bool {
        if email.contains("@") {
            return true
        }
        
        return false
    }
    
    func checkIdentity(firstText: String, secondText: String) -> Bool {
        if firstText == secondText {
            return true
        }
        
        return false
    }
    
    func checkCountValue(password: String) -> Bool {
        if password.count >= 6 {
            return true
        }
        
        return false
    }
    
    func checkFullness(first: String, second: String, third: String) -> Bool {
        if first != "" && second != "" && third != "" {
            return true
        }
        
        return false
    }
}
