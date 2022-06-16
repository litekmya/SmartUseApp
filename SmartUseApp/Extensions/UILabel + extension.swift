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
    
    func customizeDate(label:UILabel, view: UIView, topView: UIView) {
        label.snp.makeConstraints { make in
            make.leading.equalTo(view).inset(30)
            make.top.equalTo(topView.snp.bottom).inset(-30)
            make.width.equalTo(200)
        }
        
        label.text = "Дата покупки:"
    }
}

