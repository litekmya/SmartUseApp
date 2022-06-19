//
//  AppleAuthManager.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 14.06.2022.
//

import Foundation
import AuthenticationServices

enum AuthToken {
    case apple(pass: String, name: String)
}

class AppleAuthManager {
    
    static let shared = AppleAuthManager()
    
    private init() {}
    
    func authorize(delegate: ASAuthorizationControllerDelegate, contextController: ASAuthorizationControllerPresentationContextProviding) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = delegate
        controller.presentationContextProvider = contextController
        controller.performRequests()
    }
}