//
//  StatisticsViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 16.07.2022.
//

import Foundation

protocol StatisticsViewModelProtocol {
    
    var name: String { get }
    var date: String { get }
    var cost: String { get }
    
    init(thing: CoreDataThing)
}

class StatisticsViewModel: StatisticsViewModelProtocol {
    
    var name: String {
        thing.name ?? ""
    }
    
    var date: String {
        thing.date ?? ""
    }
    
    var cost: String {
        thing.cost ?? ""
    }
    
    private var thing: CoreDataThing
    
    required init(thing: CoreDataThing) {
        self.thing = thing
    }
}
