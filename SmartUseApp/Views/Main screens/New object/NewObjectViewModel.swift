//
//  NewObjectViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 27.05.2022.
//

import Foundation

protocol NewObjectViewModelProtocol {
   
    func save(name: String, cost: String, date: String, imageURL: String, imageData: Data)
}

class NewObjectViewModel: NewObjectViewModelProtocol {
    
    func save(name: String, cost: String, date: String, imageURL: String, imageData: Data) {
        let thing = Thing(name: name, cost: cost, date: date, imageURL: imageURL)
        
        FirebaseManager.shared.addNewThing(thing: thing, imageData: imageData)
    }
}
