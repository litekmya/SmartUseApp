//
//  FirebaseManager.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import Foundation
import Firebase

class FirebaseManager {
    
    static let shared = FirebaseManager()
    let firebaseApp = FirebaseApp.self

    private init() {}
    
    func send() {
        
    }
    
    func createUser(with email: String, and password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let result = result else { return }
            print(result.user.uid)
        }
    }
    
    
}
