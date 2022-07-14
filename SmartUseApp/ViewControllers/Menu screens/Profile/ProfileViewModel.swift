//
//  ProfileViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 06.07.2022.
//

import Foundation

protocol ProfileViewModelProtocol {
    var profileChanges: [ProfileChange] { get }
    
    func getData()
    func returnNumberOfRows() -> Int
    func logOff()
    func checkForIdentity(firstPass: String, secondPass: String) -> Bool
    func check(password: String) -> Bool
    func check(email: String) -> Bool
    func deleteUser(completion: @escaping(Bool) -> Void)
    func deleteAllThings()
    func change(email: String, completion: @escaping(Error?) -> Void)
    func change(password: String, completion: @escaping(Error?) -> Void)
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    var profileChanges: [ProfileChange] = []
    
    private let firebaseManager = FirebaseManager.shared
    private let validator = Validator.shared
    
    func getData() {
        profileChanges = ProfileChange.getData()
        
    }
    
    func returnNumberOfRows() -> Int {
        profileChanges.count
    }
    
    func logOff() {
        firebaseManager.signOut()
    }
    
    func checkForIdentity(firstPass: String, secondPass: String) -> Bool {
        if Validator.shared.checkIdentity(firstText: firstPass, secondText: secondPass) {
            return true
        }
        return false
    }
    
    func check(password: String) -> Bool {
        if validator.checkCountValue(password: password) {
            return true
        }
        return false
    }
    
    func check(email: String) -> Bool {
        if validator.check(email: email) {
            return true
        }
        return false
    }
    
    func deleteUser(completion: @escaping(Bool) -> Void) {
        firebaseManager.deleteUserFromAuth { boolian in
            print(boolian)
            completion(boolian)
        }
    }
    
    func deleteAllThings() {
        let things = CoreDataManager.shared.fetchData()
        
        for thing in things {
            firebaseManager.deleteImageFromFirebaseStorage(thing: thing)
            CoreDataManager.shared.delete(thing: thing)
        }
    }
    
    func change(email: String, completion: @escaping(Error?) -> Void) {
        firebaseManager.change(email: email) { error in
            completion(error)
        }
    }
    
    func change(password: String,completion: @escaping(Error?) -> Void) {
        firebaseManager.change(password: password) { error in
            completion(error)
        }
    }
}
