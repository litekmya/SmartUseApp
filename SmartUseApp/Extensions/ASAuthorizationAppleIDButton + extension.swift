//
//  ASAuthorizationAppleIDButton + extension.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 14.06.2022.
//

import Foundation
import AuthenticationServices

extension ASAuthorizationAppleIDButton {

    func setupLayout(button: ASAuthorizationAppleIDButton, with view: UIView){
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view).inset(30)
            make.centerX.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(48)
        }
    }
}


