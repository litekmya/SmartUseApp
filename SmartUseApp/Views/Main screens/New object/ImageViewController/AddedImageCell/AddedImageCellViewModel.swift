//
//  AddedImageCellViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 30.05.2022.
//

import Foundation

protocol AddedImageCellViewModelProtocol {
    var imageName: String { get }
    init(icon: Icon)
}

class AddedImageCellViewModel: AddedImageCellViewModelProtocol {
    
    var imageName: String {
        icon.imageName
    }
    
    var icon: Icon
    
    required init(icon: Icon) {
        self.icon = icon
    }
}
