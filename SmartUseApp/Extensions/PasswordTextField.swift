//
//  PasswordTextField.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 12.07.2022.
//

import UIKit

class PasswordTextField: UITextField {
    
    let showPassButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        
        return button
    }()
    
    func setup(keyType: UIReturnKeyType) {
        placeholder = "Password"
        isSecureTextEntry = true
        borderStyle = .roundedRect
        autocorrectionType = .no
        autocapitalizationType = .none
        textContentType = .password
        rightView = showPassButton
        rightViewMode = .always
        returnKeyType = keyType
    }
    
    func customizeLayout(topView: UIView) {
        snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(32)
        }
    }
    
    func changeImageForButton() {
        isSecureTextEntry = !isSecureTextEntry
        
        if !isSecureTextEntry {
            showPassButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            showPassButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
}
