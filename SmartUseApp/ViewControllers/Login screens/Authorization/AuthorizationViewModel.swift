//
//  AuthorizationViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 18.05.2022.
//

import Foundation
import AuthenticationServices

protocol AuthorizationViewModelProtocol {
    
    func checkFieldsForFullness(email: String, password: String) -> Bool
    func logIn(email: String, password: String, completion: @escaping (Error?) -> Void)
    func logInWithApple(delegate: ASAuthorizationControllerDelegate, contextController: ASAuthorizationControllerPresentationContextProviding)
    func getNonce() -> String?
    func checkAuthWithApple(auth: ASAuthorization)
}

class AuthorizationViewModel: AuthorizationViewModelProtocol {
    
    func checkFieldsForFullness(email: String, password: String) -> Bool {
        if Validator.shared.checkFullness(first: email, second: password, third: "some") {
            return true
        }
        
        return false
    }

    func logIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        FirebaseManager.shared.signIn(with: email, and: password) { error in
            completion(error)
        }
    }
    
    func logInWithApple(delegate: ASAuthorizationControllerDelegate, contextController: ASAuthorizationControllerPresentationContextProviding) {
        AppleAuthManager.shared.authorize(delegate: delegate, contextController: contextController)
    }
    
    func getNonce() -> String? {
        AppleAuthManager.shared.currentNonce
    }
    
    func checkAuthWithApple(auth: ASAuthorization) {
        if let appleIDCredential = auth.credential as? ASAuthorizationAppleIDCredential {
            UserDefaults.standard.set(appleIDCredential.user, forKey: "appleAuthorizedUserIdKey")
            
            guard let nonce = AppleAuthManager.shared.currentNonce else {
                print("Неверное состояние: обратный вызов для входа получен, но запрос на вход не отправлен")
                return
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Не удалось получить токен идентификации")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Невозможно сериализовать строку токена из данных: \(appleIDToken.debugDescription)")
                return 
            }
            
            FirebaseManager.shared.signInWithAppleID(idTokenString: idTokenString, nonce: nonce)
        }
    }
}
