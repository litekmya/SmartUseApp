//
//  ProfileChange.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 06.07.2022.
//

import Foundation

struct ProfileChange {
    var title: String
    
    static func getData() -> [ProfileChange] {
        return [ProfileChange(title: "Изменить email"),
                ProfileChange(title: "Изменить пароль"),
                ProfileChange(title: "Удалить профиль")]
    }
}


