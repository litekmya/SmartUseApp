//
//  AcquaintanceViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 23.05.2022.
//

import Foundation

protocol AcquaintanceViewModelProtocol {
    var pages: [Page] { get }
    
    func getPagesData()
    func returnNumberOfItemsInSection() -> Int
    func getCellViewModel(at index: Int) -> AcquaintanceCellViewModelProtocol?
}

class AcquaintanceViewModel: AcquaintanceViewModelProtocol {
        
    var pages: [Page] = []
    
    func getPagesData() {
        pages = Page.getData()
    }
        
    func returnNumberOfItemsInSection() -> Int {
        return pages.count
    }
    
    func getCellViewModel(at index: Int) -> AcquaintanceCellViewModelProtocol? {
        let page = pages[index]
        
        return AcquaintanceCellViewModel(page: page)
    }
}
