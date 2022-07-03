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
        guard let urlString = thing.urlString else {
            guard let data = thing.imageData else {
                return
            }
            completion(data)
            return
            
        }
        NetworkManager.shared.getImage(from: urlString) { data in
            print("Данные из интернета получены")
            completion(data)
        }
    }
}
