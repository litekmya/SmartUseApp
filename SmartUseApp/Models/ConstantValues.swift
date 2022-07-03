//
//  ConstantValues.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import Foundation

enum Text: String {
    case auth = "Авторизация"
    case registration = "Регистрация"
    case regText = "Введите email и пароль"
    case logInButtonTitle = "Войти"
    case forgotPassButonTitle = "Забыли пароль?"
    case resetPassButtonTitle = "Сбросить"
    case registratonLabelText = "Если у вас нет действующего аккаунта, то вы можете"
    case registrationButtonTitle = "Зарегистрироваться здесь"
    case errorLabelText = "Введен неверный email и/или пароль"
}

enum ErrorText: String {
    case emailRegError = "Такой аккаунт уже существует"
    case passRegError = "Пароли должны совпадать"
    case incorrectPassError = "Пароль должен содержать не менее 6 знаков"
    case emailRecoveryError = "Введен неправильный email адресс"
}

enum PlaceholderText: String {
    case email = "Email"
    case password = "Password"
    case name = "Наименование"
    case cost = "Цена"
}

enum ImageConstants: Int {
    case topAndHeight = 90
}

enum LabelsConstants: Int {
    case top = 35
    case left = 20
    case errorTop = 10
    case errorLeft = 30
}

enum TextFieldConstants: Int {
    case top = 20
    case left = 50
}

enum ButtonConstants: Int {
    case centerTop = -5
    case bottom = 40
    case height = 48
    case wigth = 127
    case leadingAndTrailing = 45
}
