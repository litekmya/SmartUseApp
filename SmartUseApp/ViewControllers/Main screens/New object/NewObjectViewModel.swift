//
//  NewObjectViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 27.05.2022.
//

import Foundation

protocol NewObjectViewModelProtocol {
    func save(name: String, cost: String, date: String, urlString: String, imageData: Data)
}

class NewObjectViewModel: NewObjectViewModelProtocol {
            
    func save(name: String, cost: String, date: String, urlString: String, imageData: Data) {
        let thing = Thing(name: name, cost: cost, date: date, urlString: urlString)
        
        CoreDataManager.shared.save(from: thing, imageData: imageData)
        FirebaseManager.shared.addNewThing(thing: thing, imageData: imageData)
    }
}
