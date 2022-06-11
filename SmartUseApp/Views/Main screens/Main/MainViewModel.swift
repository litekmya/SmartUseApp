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
    func getCellViewModel(index: Int) -> MainCellViewModelProtocol
}

class MainViewModel: MainViewModelProtocol {
    
    var things: [Thing] = []
    
    func getDataFromDatabase(completion: @escaping() -> Void) {
        FirebaseManager.shared.getThingsFromDatabase { values in
            for (_, value) in values {
                guard let name = value["name"] as? String,
                      let cost = value["cost"] as? String,
                      let date = value["date"] as? String,
                      let urlString = value["urlString"] as? String
                else {
                    print("Ошибка во MainViewModel/values ")
                    return }
                
                let thing = Thing(name: name, cost: cost, date: date, urlString: urlString)
                self.things.append(thing)
            }
            
            completion()
        }
    }
    
    func returnNumberOfItemsInSection() -> Int {
        things.count
    }
    
    func getCellViewModel(index: Int) -> MainCellViewModelProtocol {
        let thing = things[index]
        
        return MainCellViewModel(thing: thing)
    }
}
