//
//  UIButton + extension.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 19.05.2022.
//

import UIKit
import SnapKit

extension UIButton {
    
    func setup(title: String, buttonIsEnabled: Bool) {
        setTitleColor(.lightGray, for: .disabled)
        setTitleColor(.systemBlue, for: .normal)
        setTitle(title, for: .normal)
        isEnabled = buttonIsEnabled
    }
    
    func customizeCenter(height: Int, width: Int) {
        snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
    }
    
    func adjustOnAxisY(view: UIView, top: Int?, bottom: Int?) {
        snp.makeConstraints { make in
            if top == nil {
                guard let bottom = bottom else { return }
                make.bottom.equalTo(view).inset(bottom)
            } else {
                guard let top = top else { return }
                make.top.equalTo(view.snp.bottom).inset(top)
            }
        }
    }
    
    func adjustOnAxisX(view: UIView, leading: Int?, trailing: Int?) {
        snp.makeConstraints { make in
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
