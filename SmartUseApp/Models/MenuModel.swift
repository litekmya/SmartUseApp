//
//  MenuModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 05.07.2022.
//

import Foundation
import UIKit

enum MenuModel: Int, CustomStringConvertible {
    case profile
    case settings
    case about
    
    var description: String {
        switch self {
        case .profile: return "Профиль"
        case .settings: return "Настройки"
        case .about: return "О приложении"
        }
    }
    
    var iconImage: UIImage {
        switch self {
        case .profile: return UIImage(systemName: "star") ?? UIImage()
        case .settings: return UIImage(systemName: "star") ?? UIImage()
        case .about: return UIImage(systemName: "star") ?? UIImage()
        }
    }
}
