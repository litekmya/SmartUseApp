//
//  ConstantValues.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import Foundation

enum Text: String {
    case login = "Login"
    case password = "Password"
    case auth = "Авторизация"
    case registration = "Регистрация"
    case regText = "Введите логин и пароль"
    case loginRegError = "Такой аккаунт уже существует"
    case passRegError = "Пароли должны совпадать"
}

enum ImageConstants: Int {
    case topAndHeight = 90
}

enum LabelsConstants: Int {
    case top = -35
    case left = 20
    case errorTop = -10
    case errorLeft = 30
}

enum TextFieldConstants: Int {
    case top = 20
    case left = 50
}

enum ButtonConstants: Int {
    case centerTop = -20
    case bottom = 40
    case height = 48
    case wigth = 127
    case leadingAndTrailing = 45
}