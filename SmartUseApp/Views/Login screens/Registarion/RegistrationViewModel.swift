//
//  RegistrationViewModel.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import Foundation

protocol RegistrationViewModelProtocol {
   
    func register(email: String, password: String)
}

class RegistrationViewModel: RegistrationViewModelProtocol {

    func register(email: String, password: String) {
        FirebaseManager.shared.createUser(with: email, and: password)
    }
}
