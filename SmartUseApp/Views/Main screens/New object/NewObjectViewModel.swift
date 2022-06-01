//
//  NewObjectViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 27.05.2022.
//

import Foundation

protocol NewObjectViewModelProtocol {
   
    func save(name: String, cost: String, date: String)
}

class NewObjectViewModel: NewObjectViewModelProtocol {
    
    func save(name: String, cost: String, date: String) {
        let thing = Thing(name: name, cost: cost, date: date)
        FirebaseManager.shared.addNewThing(thing: thing)
    }
}
