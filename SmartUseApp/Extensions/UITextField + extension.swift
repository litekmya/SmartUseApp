//
//  UITextField + extension.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 19.05.2022.
//

import UIKit
import SnapKit

extension UITextField {
    
    func customize(topView: UIView) {
        snp.makeConstraints { maker in
            maker.left.right.equalToSuperview().inset(32)
            maker.top.equalTo(topView.snp.bottom).inset(-16)
        }
    }
    
    func setupTextInput(placeholderText: String, contentType: UITextContentType, keyboard: UIKeyboardType) {
        textContentType = contentType
        keyboardType = keyboard
        returnKeyType = .done
        autocapitalizationType = .none
        autocorrectionType = .no
        placeholder = placeholderText
        borderStyle = .roundedRect
        clearButtonMode = .always
    }
}
