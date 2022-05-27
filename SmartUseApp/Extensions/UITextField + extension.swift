//
//  UITextField + extension.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 19.05.2022.
//

import UIKit
import SnapKit

extension UITextField {
    
    func customize(textField: UITextField, view: UIView, placeholder: String, top: Int, left: Int) {
        textField.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview().inset(32)
            maker.top.equalTo(view.snp.bottom).inset(-16)
        }
        
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
    }
    
    func setupTextInput(_ textField: UITextField, contentType: UITextContentType, delegate: UITextFieldDelegate ) {
        textField.textContentType = contentType
        textField.returnKeyType = .done
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.delegate = delegate
    }
}
