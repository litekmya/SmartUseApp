//
//  MenuCellViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 05.07.2022.
//

import Foundation

protocol MenuCellViewModelProtocol {
    
    var title: String { get }
    var image: String { get }
    
    init(menuDescription: MenuDescription)
}

class MenuCellViewModel: MenuCellViewModelProtocol {
    
    var title: String {
        menuDescription.title
    }

    var image: String {
        menuDescription.image
    }
    
    private let menuDescription: MenuDescription
    
    required init(menuDescription: MenuDescription) {
        self.menuDescription = menuDescription
    }
}
