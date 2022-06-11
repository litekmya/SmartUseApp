//
//  FirebaseManager.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseManager {
    
    static let shared = FirebaseManager()
    let firebaseApp = FirebaseApp.self
        
    private init() {}
    
    func createUser(with email: String, and password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error Firebase/createUser: \(error.localizedDescription)")
            }
            
            guard let result = result else { return }
            print(result.user.uid)
            
            Database.database().reference().child("users").child(result.user.uid).updateChildValues(["email": email, "password": password])
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Error Firebase/signOut: \(error.localizedDescription)")
        }
    }
    
    func signIn(with email: String, and Password: String, completion: @escaping(Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: Password) { result, error in
            if let error = error {
                print("Error Firebase/signIn: \(error.localizedDescription)")
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
                print("Error Firebase/recoverPass: \(error.localizedDescription)")
            } else {
                print("Востановление пользователя")
            }
            
            completion(error)
        }
    }
    
    func addNewThing(thing: Thing, imageData: Data) {
        guard let user = Auth.auth().currentUser else { return }
        print(user.uid)
        uploadImage(data: imageData, user: user, thing: thing) { urlString in
            Database.database()
                .reference()
                .child("users")
                .child(user.uid)
                .child("things")
                .child("\(thing.name)")
                .setValue(["name": thing.name,
                           "cost": thing.cost,
                           "date": thing.date,
                           "urlString": urlString])
        }
        
    }
    
    func getThingsFromDatabase(completion: @escaping([String: AnyObject]) -> Void) {
        guard let user = Auth.auth().currentUser else {
            print("Ошибка при получении текущего пользователя")
            return }
        
        Database.database()
            .reference()
            .child("users")
            .child(user.uid)
            .child("things")
            .observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: AnyObject] else {
                print("Ошибка при получении данных из базы")
                return }
            completion(value)
        }
    }
    
    private func uploadImage(data: Data, user: User, thing: Thing, completion: @escaping(String) -> Void) {
        let reference = Storage.storage()
            .reference()
            .child("users")
            .child(user.uid)
            .child("things")
            .child("\(thing.name)/image")
        
        reference.putData(data, metadata: nil) { _, error in
            if let error = error {
                print("Error Firebase/uploadImage: \(error)")
                return
            }
            
            reference.downloadURL { url, error in
                if let error = error {
                    print("Error Firebase/uploadImage/putData: \(error.localizedDescription)")
                }
                
                guard let urlString = url?.absoluteString else { return }
                
                completion(urlString)
            }
        }
    }
}
