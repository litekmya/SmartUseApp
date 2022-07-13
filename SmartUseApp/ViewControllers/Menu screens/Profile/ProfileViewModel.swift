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
    func deleteUser(completion: @escaping(Bool) -> Void)
    func deleteAllThings()
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    var profileChanges: [ProfileChange] = []
    
    func getData() {
        profileChanges = ProfileChange.getData()
        
    }
    
    func returnNumberOfRows() -> Int {
        profileChanges.count
    }
    
    func logOff() {
        FirebaseManager.shared.signOut()
    }
    
    func deleteUser(completion: @escaping(Bool) -> Void) {
        FirebaseManager.shared.deleteUserFromAuth { boolian in
            print(boolian)
            completion(boolian)
        }
    }
    
    func deleteAllThings() {
        let things = CoreDataManager.shared.fetchData()
        
        for thing in things {
            FirebaseManager.shared.deleteImageFromFirebaseStorage(thing: thing)
            CoreDataManager.shared.delete(thing: thing)
        }
    }
}
