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
    var imageName: String
    var controller: UIViewController
    
    static func getData() -> [MenuDescription] {
        return [
            MenuDescription(title: "Профиль", imageName: "icon6", controller: ProfileViewController()),
            MenuDescription(title: "Настройки", imageName: "icon11", controller: SettingsViewController()),
            MenuDescription(title: "О приложении", imageName: "icon7", controller: AboutViewController())
        ]
    }
}

