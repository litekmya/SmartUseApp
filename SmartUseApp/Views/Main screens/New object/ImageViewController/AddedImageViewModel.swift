//
//  AddedImageViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 30.05.2022.
//

import Foundation

protocol AddedImageViewModelProtocol {
    var icons: [Icon] { get }
    
    func getIcons()
    func returnNumberOfItemsInSection() -> Int
    func getCellViewModel(at index: Int) -> AddedImageCellViewModelProtocol
}

class AddedImageViewModel: AddedImageViewModelProtocol {
    var icons: [Icon] = []
    
    func getIcons() {
        icons = Icon.getIcons()
    }
    
    func returnNumberOfItemsInSection() -> Int {
        icons.count
    }
    
    func getCellViewModel(at index: Int) -> AddedImageCellViewModelProtocol {
        let icon = icons[index]
        
        return AddedImageCellViewModel(icon: icon)
    }
}
