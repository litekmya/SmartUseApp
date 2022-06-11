//
//  AcquaintanceCellViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 23.05.2022.
//

import Foundation

protocol AcquaintanceCellViewModelProtocol {
    var title: String { get }
    var text: String { get }
    var imageURL: String { get }
    
    init(page: Page)
}

class AcquaintanceCellViewModel: AcquaintanceCellViewModelProtocol {
    
    var title: String {
        page.title
    }
    
    var text: String {
        page.text
    }
    
    var imageURL: String {
        page.image
    }
    
    private var page: Page
    
    required init(page: Page) {
        self.page = page
    }
}
