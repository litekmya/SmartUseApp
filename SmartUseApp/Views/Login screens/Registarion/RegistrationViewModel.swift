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
    
    init(email: String, password: String)
    func register(email: String, password: String)
}

class RegistrationViewModel: RegistrationViewModelProtocol {
    
    var email: String {
        didSet {}
    }
    
    var password: String {
        didSet {}
    }
    
//    var viewModelDidChange: ((RegistrationViewModelProtocol) -> Void)?
    
    required init(email: String, password: String) {
        self.email = email
        self.password = password
        print("init() \(email)")
    }
    
    func register(email: String, password: String) {
        self.email = email
        self.password = password
        
        FirebaseManager.shared.createUser(with: email, and: password)
    }
}
