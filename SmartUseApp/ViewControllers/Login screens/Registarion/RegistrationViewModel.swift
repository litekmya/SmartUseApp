//
//  RegistrationViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import Foundation

protocol RegistrationViewModelProtocol {
   
    func check(email: String, completion: @escaping(AuthResult) -> Void)
    func check(password: String, completion: @escaping(AuthResult) -> Void)
    func checkForIdentity(firstPass: String, secondPass: String, completion: @escaping(AuthResult) -> Void)
    
    func checkFieldsForFullness(email: String, fisrtPass: String, secondPass: String) -> Bool
    func register(email: String, password: String, completion: @escaping(AuthResult) -> Void)

}

class RegistrationViewModel: RegistrationViewModelProtocol {
    
    private let validator = Validator.shared
    
    func check(email: String, completion: @escaping(AuthResult) -> Void) {
        guard validator.check(email: email) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
    }
    
    func check(password: String, completion: @escaping(AuthResult) -> Void) {
        guard validator.checkCountValue(password: password) else {
            completion(.failure(AuthError.shortPassword))
            return
        }
    }
    
    func checkForIdentity(firstPass: String, secondPass: String, completion: @escaping (AuthResult) -> Void) {
        guard validator.checkIdentity(firstText: firstPass, secondText: secondPass) else {
            completion(.failure(AuthError.passwordMismatch))
            return
        }
    }
    
    func checkFieldsForFullness(email: String, fisrtPass: String, secondPass: String) -> Bool {
        if validator.checkFullness(first: email, second: fisrtPass, third: secondPass) {
            return true
        }
        return false
    }

    func register(email: String, password: String, completion: @escaping(AuthResult) -> Void) {        
        FirebaseManager.shared.createUser(with: email, and: password)
        completion(.success)
    }
}
