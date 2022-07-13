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
    var databaseReference: DatabaseReference!
    var storageReference: StorageReference!
        
    private init() {}
    
    func getUser() {
        user = Auth.auth().currentUser
        databaseReference = Database.database().reference().child("users").child(user.uid)
        storageReference = Storage.storage().reference().child("users").child(user.uid)
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
            
//            guard let result = result else { return }
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
                print("Востановление пароля")
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
    func deleteUserFromAuth(completion: @escaping(Bool) -> Void) {
        user?.delete(completion: {[unowned self] error in
            if let error = error {
                print("Ошибка при удалении профиля: \(error.localizedDescription)")
                completion(false)
//                self.signOut()
            } else {
                self.deleteUserFromRealTimeDatabase()
                print("Профиль пользователя был удален из Firebase/Authorization")
                completion(true)
            }
        })
    }
    
    func deleteUserFromRealTimeDatabase() {
        databaseReference.removeValue()
        print("Профиль пользователя был удален из Firebase/RealTimeDatabase")
    }
    
    //MARK: - Objects
    func addNewThing(thing: Thing, imageData: Data) {
        uploadImage(data: imageData, user: user, thing: thing) {[unowned self] urlString in
            self.databaseReference
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
        databaseReference
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
        
        databaseReference
            .child("things")
            .child(thing.name ?? "")
            .removeValue()
    }
    
    //MARK: - Storage firebase
    func deleteImageFromFirebaseStorage(thing: CoreDataThing) {
        guard let thingName = thing.name else { return }
        
        storageReference
            .child("things")
            .child("\(thingName)/image")
            .delete { error in
            if let error = error {
                print("Ошибка при удалении изображения из FirebaseStorage: \(error.localizedDescription)")
            } else {
                print("\(thing.name) image был удален")
            }
        }
    }
    
    private func uploadImage(data: Data, user: User, thing: Thing, completion: @escaping(String) -> Void) {
        let reference = storageReference.child("things").child("\(thing.name)/image")
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
