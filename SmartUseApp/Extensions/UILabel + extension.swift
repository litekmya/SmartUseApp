//
//  UILabel + extension.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 19.05.2022.
//

import UIKit
import SnapKit

extension UILabel {
    
    func customize(label: UILabel, view: UIView, text: String, top: Int, left: Int) {
        label.snp.makeConstraints { maker in
            maker.top.equalTo(view.snp.bottom).inset(top)
            maker.left.right.equalToSuperview().inset(left)
        }
        
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
    }
}

