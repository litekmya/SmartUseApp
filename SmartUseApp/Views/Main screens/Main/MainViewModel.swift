//
//  WelcomeViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import Foundation

protocol MainViewModelProtocol {
    var things: [Thing] { get }
    
    func getDataFromDatabase(completion: @escaping() -> Void)
    func returnNumberOfItemsInSection() -> Int
}

class MainViewModel: MainViewModelProtocol {
    
    var things: [Thing] = []
    
    func getDataFromDatabase(completion: @escaping() -> Void) {
        FirebaseManager.shared.getThingsFromDatabase { values in
            for (_, value) in values {
                guard let name = value["name"] as? String,
                      let cost = value["cost"] as? String,
                      let date = value["date"] as? String
                else { return }
                let thing = Thing(name: name, cost: cost, date: date)
                
                self.things.append(thing)
            }
            
            print(self.things.count)
            completion()
        }
    }
    
    func returnNumberOfItemsInSection() -> Int {
        things.count
    }
}
