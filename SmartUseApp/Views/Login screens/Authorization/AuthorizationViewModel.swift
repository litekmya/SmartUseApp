//
//  AuthorizationViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 18.05.2022.
//

import Foundation
import AuthenticationServices

protocol AuthorizationViewModelProtocol {

    func logIn(email: String, password: String, completion: @escaping (Error?) -> Void)
    func logInWithApple(delegate: ASAuthorizationControllerDelegate, contextController: ASAuthorizationControllerPresentationContextProviding)
}

class AuthorizationViewModel: AuthorizationViewModelProtocol {

    func logIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        FirebaseManager.shared.signIn(with: email, and: password) { error in
            completion(error)
        }
    }
    
    func logInWithApple(delegate: ASAuthorizationControllerDelegate, contextController: ASAuthorizationControllerPresentationContextProviding) {
        AppleAuthManager.shared.authorize(delegate: delegate, contextController: contextController)
    }
}
