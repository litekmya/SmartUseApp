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
    init(thing: Thing)
}

class ThingDescriptionViewModel: ThingDescriptionViewModelProtocol {
    
    var name: String {
        thing.name
    }
    
    var imageData: Data? {
        thing.imageData
    }
    
    var date: String {
        thing.date
    }
    
    var cost: String {
        thing.cost
    }
    
    
    private var thing: Thing!
    
    required init(thing: Thing) {
        self.thing = thing
    }
}
