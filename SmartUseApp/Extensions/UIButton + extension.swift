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
    
    func customizeLeftBarButton(parentView: UIView) {
        snp.makeConstraints { make in
            make.top.equalTo(parentView).inset(70)
            make.leading.equalTo(parentView).inset(30)
            make.width.height.equalTo(30)
        }
    }
    
    func customizeRightBarButton(parentView: UIView) {
        snp.makeConstraints { make in
            make.trailing.equalTo(parentView).inset(30)
            make.top.equalTo(parentView).inset(70)
            make.height.width.equalTo(30)
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
