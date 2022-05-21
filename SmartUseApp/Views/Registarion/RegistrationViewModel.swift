//
//  RegistrationViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import Foundation

protocol RegistrationViewModelProtocol {
    var email: String { get }
    var password: String { get }
    var viewModelDidChange: ((RegistrationViewModelProtocol) -> Void)? { get set }
    
    init(authModel: AuthModel)
    func transferData(auth: AuthModel) // переименовать метод правильно
}

class RegistrationViewModel: RegistrationViewModelProtocol {
    
    var email: String {
//        get {
//            auth.email
//        } set {
//            self.email = newValue
//            print(email)
//        }
        
        didSet {
            viewModelDidChange.self
        }
    }
    
    var password: String {
//        get {
//            auth.password
//        } set {
//            self.password = newValue
//            print(password)
//        }
        
        didSet {
            viewModelDidChange.self
        }
    }
    
    var viewModelDidChange: ((RegistrationViewModelProtocol) -> Void)?
    
    private var auth: AuthModel
    
    required init(authModel: AuthModel) {
        self.auth = authModel
        self.email = ""
        self.password = ""
    }
    
    func transferData(auth: AuthModel) {
//        email = auth.email
//        password = auth.password
        print(auth.email)
        print(auth.password)
        // добавить метод, который будет регистрировать нового пользователя
    }
}
