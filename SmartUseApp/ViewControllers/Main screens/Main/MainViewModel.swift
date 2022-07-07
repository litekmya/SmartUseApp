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
    func getUserFromFirebase()
}


class MainViewModel: MainViewModelProtocol {
    
    var things: [Thing] = []
    var coreDataThings: [CoreDataThing]!
    
    func getData(completion: @escaping() -> Void) {
        coreDataThings = CoreDataManager.shared.fetchData()
        
        if coreDataThings == [] {
            getDataFromFirebase {
                completion()
            }
        } else {
            getDataFromCoreData()
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
    
    func getUserFromFirebase() {
        FirebaseManager.shared.getUser()
    }
    
    private func getDataFromFirebase(completion:@escaping() -> Void) {
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
                
                DispatchQueue.main.async {
                    guard let urlString = thing.urlString else  { return }
                    NetworkManager.shared.getImage(from: urlString) { data in
                        CoreDataManager.shared.save(from: thing, imageData: data)
                    }
                }
                
                self.things.append(thing)
                print("Данные из firebase получены")
            }
            
            completion()
        }
    }
    
    private func getDataFromCoreData() {
        for coreDataThing in self.coreDataThings {
            let thing = Thing(
                name: coreDataThing.name ?? "",
                cost: coreDataThing.cost ?? "",
                date: coreDataThing.date ?? "",
                urlString: nil,
                imageData: coreDataThing.imageData
            )
            self.things.append(thing)
            print("Данные из coreData получены")
        }
    }
}


