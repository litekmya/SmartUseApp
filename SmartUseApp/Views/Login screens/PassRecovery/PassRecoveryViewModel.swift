//
//  PassRecoveryViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 24.05.2022.
//

import Foundation

protocol PassRecoveryViewModelProtocol {

    func recoverPass(with email: String, completion: @escaping(Error?) -> Void)
}

class PassRecoveryViewModel: PassRecoveryViewModelProtocol {
    
    func recoverPass(with email: String, completion: @escaping(Error?) -> Void) {
        FirebaseManager.shared.recoverPassword(with: email) { error in
            completion(error)
        }
    }
}
