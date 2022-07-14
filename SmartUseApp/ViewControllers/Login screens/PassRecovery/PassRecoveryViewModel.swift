//
//  PassRecoveryViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 24.05.2022.
//

import Foundation

protocol PassRecoveryViewModelProtocol {
    func check(email: String) -> Bool
    func recoverPass(with email: String, completion: @escaping(Error?) -> Void)
}

class PassRecoveryViewModel: PassRecoveryViewModelProtocol {
    
    private let firebaseManager = FirebaseManager.shared
    
    func check(email: String) -> Bool {
        if Validator.shared.check(email: email) {
            return true
        }
        return false
    }
    
    func recoverPass(with email: String, completion: @escaping(Error?) -> Void) {
        firebaseManager.recoverPassword(with: email) { error in
            completion(error)
        }
    }
}
