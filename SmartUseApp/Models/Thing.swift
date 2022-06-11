//
//  Thing.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 31.05.2022.
//

import Foundation

struct Thing: Codable {
    var name: String
    var cost: String
    var date: String
    var urlString: String?
    var imageData: Data?
}

