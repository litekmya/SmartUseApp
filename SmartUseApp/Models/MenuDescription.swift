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
    var controller: UIViewController
    
    static func getData() -> [MenuDescription] {
        return [
            MenuDescription(title: "Профиль", image: "star", controller: ProfileViewController()),
            MenuDescription(title: "Настройки", image: "star", controller: SettingsViewController()),
            MenuDescription(title: "О приложении", image: "star", controller: AboutViewController())
        ]
    }
}

