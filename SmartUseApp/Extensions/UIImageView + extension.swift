//
//  UIImageView + extension.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 19.05.2022.
//

import UIKit
import SnapKit

extension UIImageView {
    
    func customize(from view: UIView) {
        snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.height.width.equalTo(90)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
}
