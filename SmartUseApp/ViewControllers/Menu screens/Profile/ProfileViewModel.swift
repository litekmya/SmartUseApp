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
    func deleteUser()
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
    
    func deleteUser() {
        FirebaseManager.shared.deleteUserFromAuth()
        deleteAllThingsInCoreData()
    }
    
    private func deleteAllThingsInCoreData() {
        let things = CoreDataManager.shared.fetchData()
        
        for thing in things {
            print(thing.name)
//            FirebaseManager.shared.deleteImageFromFirebaseStorage(thing: thing)
            CoreDataManager.shared.delete(thing: thing)
        }
    }
}
