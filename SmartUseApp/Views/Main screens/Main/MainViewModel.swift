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
            print(values.count)
            for (_, value) in values {
                guard let name = value["name"] as? String,
                      let cost = value["cost"] as? String,
                      let date = value["date"] as? String,
                      let imageURL = value["imageURL"] as? String
                else {
                    print("Ошибка во MainViewModel/values ")
                    return }
                
                let thing = Thing(name: name, cost: cost, date: date, imageURL: imageURL)
                print(thing)
//                DispatchQueue.main.async {
//                    self.things.append(thing)
//
//                }
                self.things.append(thing)
            }
            
            print("_+_+_+\(self.things.count)")
            completion()
        }
    }
    
    func returnNumberOfItemsInSection() -> Int {
        things.count
    }
}
