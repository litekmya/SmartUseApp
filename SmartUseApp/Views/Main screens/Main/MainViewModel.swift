//
//  WelcomeViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import Foundation

protocol MainViewModelProtocol {
    var things: [Thing] { get set }
    var coreDataThings: [CoreDataThing]! { get }
    
    func getData(completion: @escaping() -> Void)
    func returnNumberOfItemsInSection() -> Int
    func getCellViewModel(index: Int) -> MainCellViewModelProtocol
    func getDescriptionViewModel(index: Int) -> ThingDescriptionViewModelProtocol
}


class MainViewModel: MainViewModelProtocol {
    
    var things: [Thing] = []
    var coreDataThings: [CoreDataThing]!
    
    func getData(completion: @escaping() -> Void) {
        coreDataThings = CoreDataManager.shared.fetchData()
        
        if coreDataThings == [] {
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
                    print("Данные из firebase получены")
                }
                
                completion()
            }
        } else {
            
            var things: [Thing] = []
            
            for coreDataThing in coreDataThings {
                let thing = Thing(
                    name: coreDataThing.name ?? "",
                    cost: coreDataThing.cost ?? "",
                    date: coreDataThing.date ?? "",
                    urlString: nil,
                    imageData: coreDataThing.imageData
                )
                things.append(thing)
                print("Данные из coreData получены")
            }
            
            self.things = things
            completion()
        }
    }
    
    func returnNumberOfItemsInSection() -> Int {
        things.count
    }
    
    func getCellViewModel(index: Int) -> MainCellViewModelProtocol {
        let thing = things[index]
        print(things.count)
        return MainCellViewModel(thing: thing)
    }
    
    func getDescriptionViewModel(index: Int) -> ThingDescriptionViewModelProtocol {
        let thing = things[index]
        return  ThingDescriptionViewModel(thing: thing)
    }
}


