//
//  AuthorizationViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 18.05.2022.
//

import Foundation

protocol AuthorizationViewModelProtocol {

    func logIn(email: String, password: String, completion: @escaping (Error?) -> Void)
}

class AuthorizationViewModel: AuthorizationViewModelProtocol {

    func logIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        FirebaseManager.shared.signIn(with: email, and: password) { error in
            completion(error)
        }
    }
}
