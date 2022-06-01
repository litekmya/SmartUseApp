//
//  Icon.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 31.05.2022.
//

import Foundation
import UIKit

struct Icon {
    var imageName: String
}

extension Icon {
    
    static func getIcons() -> [Icon] {
        let icons: [Icon] = [
            Icon(imageName: "icons8-cocktail-60"),
            Icon(imageName: "icons8-cocktail-60"),
            Icon(imageName: "icons8-cocktail-60"),
            Icon(imageName: "icons8-cocktail-60"),
            Icon(imageName: "icons8-cocktail-60"),
            Icon(imageName: "icons8-cocktail-60"),
            Icon(imageName: "icons8-cocktail-60"),
            Icon(imageName: "icons8-cocktail-60"),
            Icon(imageName: "icons8-cocktail-60"),
            Icon(imageName: "icons8-cocktail-60"),
            Icon(imageName: "icons8-cocktail-60"),
            Icon(imageName: "icons8-cocktail-60"),
            Icon(imageName: "icons8-cocktail-60")
        ]
        
        return icons
    }
}

