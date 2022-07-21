//
//  ThingDescriptionViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 16.06.2022.
//

import Foundation

protocol ThingDescriptionViewModelProtocol {
    var name: String { get }
    var imageData: Data? { get }
    var date: String { get }
    var cost: String { get }
    
    init(thing: CoreDataThing)
    func deleteThing()
    func getStatisticsViewModel() -> StatisticsViewModelProtocol
}

class ThingDescriptionViewModel: ThingDescriptionViewModelProtocol {
    
    var name: String {
        thing.name ?? ""
    }
    
    var imageData: Data? {
        thing.imageData
    }
    
    var date: String {
        thing.date ?? ""
    }
    
    var cost: String {
        thing.cost ?? ""
    }
    
    private var thing: CoreDataThing!
    
    required init(thing: CoreDataThing) {
        self.thing = thing
    }
    
    func deleteThing() {
        FirebaseManager.shared.deleteThing(thing: thing)
        CoreDataManager.shared.delete(thing: thing)
    }
    
    func getStatisticsViewModel() -> StatisticsViewModelProtocol {
        return StatisticsViewModel(thing: thing)
    }
}
