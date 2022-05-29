//
//  AuthorizationViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 18.05.2022.
//

import Foundation

protocol AuthorizationViewModelProtocol {
    var email: String { get }
    var password: String { get }
    
    init(email: String, password: String)
    func logIn(email: String, password: String, completion: @escaping (Error?) -> Void)
}

class AuthorizationViewModel: AuthorizationViewModelProtocol {
    
    var email: String {
        didSet {
            
        }
    }
    
    var password: String {
        didSet {
            
        }
    }
        
    required init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func logIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        FirebaseManager.shared.signIn(with: email, and: password) { error in
            completion(error)
        }
    }
}
