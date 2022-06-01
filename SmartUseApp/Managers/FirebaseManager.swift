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
    
    func createUser(with email: String, and password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let result = result else { return }
            print(result.user.uid)
            
            Database.database().reference().child(result.user.uid).updateChildValues(["email": email, "password": password])
        }
    }
    
    func signOut() {
        
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func signIn(with email: String, and Password: String, completion: @escaping(Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: Password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                completion(error)
            }
            
            guard let result = result else { return }
            print(result.user.uid)
            completion(error)
        }
    }
    
    func recoverPassword(with email: String, completion: @escaping(Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Востановление пользователя")
            }
            
            completion(error)
        }
    }
    
    func addNewThing(thing: Thing) {
        guard let user = Auth.auth().currentUser else { return }
        print(user.uid)
        Database.database()
            .reference()
            .child("users")
            .child(user.uid)
            .child("things")
            .child("\(thing.name)")
            .setValue(["name": thing.name,
                       "cost": thing.cost,
                       "date": thing.date])
    }
    
    func getThingsFromDatabase(completion: @escaping([String: AnyObject]) -> Void) {
        guard let user = Auth.auth().currentUser else { return }
        
        Database.database()
            .reference()
            .child("users")
            .child(user.uid)
            .child("things")
            .observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: AnyObject] else { return }
                
            completion(value)
        }
    }
}
