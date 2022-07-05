//
//  MenuDescription.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 05.07.2022.
//

import Foundation
import UIKit

struct MenuDescription {
    var title: String
    var image: String
    
    static func getData() -> [MenuDescription] {
        return [
            MenuDescription(title: "Профиль", image: "star"),
            MenuDescription(title: "Настройки", image: "star"),
            MenuDescription(title: "О приложении", image: "star")
        ]
    }
}

