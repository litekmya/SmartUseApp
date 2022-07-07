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
    var user: User!
    var reference: DatabaseReference!
        
    private init() {}
    
    func getUser() {
        user = Auth.auth().currentUser
        reference = Database.database().reference().child("users").child(user.uid)
    }
    
    //MARK: - Auth
    func createUser(with email: String, and password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error Firebase/createUser: \(error.localizedDescription)")
            }
            
            guard let result = result else { return }
            
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
    
    func signInWithAppleID(idTokenString: String, nonce: String?) {
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Error Firebase/signInWithAppleID: \(error)")
            }
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
    
    func change(password: String) {
        user.updatePassword(to: password, completion: { error in
            if let error = error {
                print("Ошибка при смене пароля: \(error.localizedDescription)")
            }
        })
    }
    
    func change(email: String) {
        user.updateEmail(to: email, completion: { error in
            if let error = error {
                print("Ошибка при смене email: \(error.localizedDescription)")
            }
        })
    }
    
    //MARK: - Delete user
    func deleteUserFromAuth() {
        user?.delete(completion: { error in
            if let error = error {
                print("Ошибка при удалении профиля: \(error.localizedDescription)")
                self.signOut()
            }
            
            print("Профиль пользователя был удален")
        })
    }
    
    func deleteUserFromRealTimeDatabase() {
        Database.database()
            .reference()
            .child("users")
            .child(user.uid)
            .removeValue()
    }
    
    //MARK: - Objects
    func addNewThing(thing: Thing, imageData: Data) {
        uploadImage(data: imageData, user: user, thing: thing) { urlString in
            Database.database()
                .reference()
                .child("users")
                .child(self.user.uid)
                .child("things")
                .child("\(thing.name)")
                .setValue(["name": thing.name,
                           "cost": thing.cost,
                           "date": thing.date,
                           "urlString": urlString])
            print("Новая вещь была сохранена")
        }
    }
    
    func getThingsFromDatabase(completion: @escaping([String: AnyObject]) -> Void) {
        Database.database()
            .reference()
            .child("users")
            .child(user.uid)
            .child("things")
            .observeSingleEvent(of: .value) { snapshot in
                guard let values = snapshot.value as? [String: AnyObject] else {
                    print("Ошибка при получении данных из базы")
                    return }
                
                completion(values)
            }
    }
    
    func deleteThing(thing: CoreDataThing) {
        deleteImageFromFirebaseStorage(thing: thing)
        
        Database.database()
            .reference()
            .child("users")
            .child(user.uid)
            .child("things")
            .child(thing.name ?? "")
            .removeValue()
        
        
    }
    
    func deleteImageFromFirebaseStorage(thing: CoreDataThing) {
        let reference = Storage.storage()
            .reference()
            .child("users")
            .child(user.uid)
            .child("things")
            .child("\(thing.name)/image")
        
        reference.delete { error in
            if let error = error {
                print("Ошибка при удалении изображения из FirebaseStorage: \(error.localizedDescription)")
            }
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
