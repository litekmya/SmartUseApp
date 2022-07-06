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
    
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    var profileChanges: [ProfileChange] = []
    
    func getData() {
        profileChanges = ProfileChange.getData()
        
    }
    
    func returnNumberOfRows() -> Int {
        profileChanges.count
    }
    
    
}
