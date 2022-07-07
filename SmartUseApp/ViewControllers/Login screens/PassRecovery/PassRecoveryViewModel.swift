//
//  PassRecoveryViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 24.05.2022.
//

import Foundation

protocol PassRecoveryViewModelProtocol {

    func recoverPass(with email: String, completion: @escaping(Error?) -> Void)
    func change(password: String)
    func change(email: String)
}

class PassRecoveryViewModel: PassRecoveryViewModelProtocol {
    
    func recoverPass(with email: String, completion: @escaping(Error?) -> Void) {
        FirebaseManager.shared.recoverPassword(with: email) { error in
            completion(error)
        }
    }
    
    func change(password: String) {
        FirebaseManager.shared.change(password: password)
    }
    
    func change(email: String) {
        FirebaseManager.shared.change(email: email)
    }
}
