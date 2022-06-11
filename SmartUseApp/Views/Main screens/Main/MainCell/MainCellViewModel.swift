//
//  MainCellViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 24.05.2022.
//

import Foundation

protocol MainCellViewModelProtocol {
    var title: String { get }
    
    init(thing: Thing)
    func getImageData(completion: @escaping(Data) ->Void)
}

class MainCellViewModel: MainCellViewModelProtocol {
    
    var title: String {
        return thing.name
    }
    private var thing: Thing
    
    required init(thing: Thing) {
        self.thing = thing
    }
    
    func getImageData(completion: @escaping(Data) ->Void) {
        let things = CoreDataManager.shared.fetchData(thingName: thing.name)
        
        if things.first == nil {
            NetworkManager.shared.getImage(from: self.thing.urlString) { data in
                print("Данные из интернета получены")
                completion(data)
            }
        } else {
            guard let thing = things.first else { return }
            guard let imageData = thing.imageData else { return }
            print("Данные из базы получены")
            completion(imageData)
        }
    }
}
