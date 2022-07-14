//
//  ErrorEnums.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 14.07.2022.
//

import Foundation

enum AuthError {
    case invalidEmailOrPassword
    case invalidEmail
    case shortPassword
    case passwordMismatch
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
            
        case .invalidEmailOrPassword:
            return NSLocalizedString("Введен неверный email или пароль", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Введен некоректный email", comment: "")
        case .shortPassword:
            return NSLocalizedString("Пароль должен быть не короче 6 символов", comment: "")
        case .passwordMismatch:
            return NSLocalizedString("Пароли не совпадают", comment: "")
        }
    }
}

enum AlertError: String {
    case passwordMismatch = "Пароли не совпадают"
    case invalidEmail = "Введен некоректный email"
    case shortPassword = "Пароль должен быть не короче 6 символов"
}

