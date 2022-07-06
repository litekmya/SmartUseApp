//
//  MenuViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 04.07.2022.
//

import Foundation
import UIKit

protocol MenuViewModelProtocol {
    var menuDescriptions: [MenuDescription] { get }
    
    func returnNumberOfRows() -> Int
    func getMenuDescriptionData()
    func getCellViewModel(at index: Int) -> MenuCellViewModelProtocol
    func goToNextVC(at index: Int) -> UIViewController
}

class MenuViewModel: MenuViewModelProtocol {
    
    var menuDescriptions: [MenuDescription] = []
    
    func returnNumberOfRows() -> Int {
        menuDescriptions.count
    }
    
    func getMenuDescriptionData() {
        menuDescriptions = MenuDescription.getData()
    }
    
    func getCellViewModel(at index: Int) -> MenuCellViewModelProtocol {
        let description = menuDescriptions[index]
        
        return MenuCellViewModel(menuDescription: description)
    }
    
    func goToNextVC(at index: Int) -> UIViewController {
        let controller = menuDescriptions[index].controller
        
        return controller
    }
}
