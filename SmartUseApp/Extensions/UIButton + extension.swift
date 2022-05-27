//
//  UIButton + extension.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 19.05.2022.
//

import UIKit
import SnapKit

extension UIButton {
    
    func setup(button: UIButton, title: String, isEnabled: Bool) {
        button.setTitleColor(.lightGray, for: .disabled)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle(title, for: .normal)
        button.isEnabled = isEnabled
    }
    
    func customizeCenter(button: UIButton, view: UIView, height: Int, width: Int) {
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
    }
    
    func customizeByAppleSign(button: UIButton) {
        var config = UIButton.Configuration.filled()
        config.title = "Sign in with Apple"
        config.image = UIImage(systemName: "applelogo")
        config.imagePadding = 16
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .black
        config.cornerStyle = .small
        
        button.configuration = config
    }
    
    func adjust(button: UIButton, view: UIView, top: Int?, bottom: Int?) {
        button.snp.makeConstraints { make in
            if top == nil {
                guard let bottom = bottom else { return }

                make.bottom.equalTo(view).inset(bottom)
            } else {
                guard let top = top else { return }
                make.top.equalTo(view.snp.bottom).inset(top)
            }
        }
    }
    
    func adjust(button: UIButton, view: UIView, leading: Int?, trailing: Int?) {
        button.snp.makeConstraints { make in
            if leading == nil {
                guard let trailing = trailing else { return }

                make.trailing.equalTo(view).inset(trailing)
            } else if trailing == nil {
                guard let leading = leading else { return }
                make.leading.equalTo(view).inset(leading)
            } else {
                guard let trailing = trailing else { return }
                guard let leading = leading else { return }
                
                make.leading.equalTo(view).inset(leading)
                make.trailing.equalTo(view).inset(trailing)
            }
            
            make.height.equalTo(view.frame.height / 15)
        }
    }
}
