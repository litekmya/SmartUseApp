//
//  UILabel + extension.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 19.05.2022.
//

import UIKit
import SnapKit

extension UILabel {
    
    func customize(parrentView: UIView, topView: UIView, newText: String, top: Int, left: Int) {
        snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(top)
            make.leading.equalTo(parrentView).offset(left)
            make.trailing.equalTo(parrentView).inset(left)
        }
        text = newText
        textAlignment = .center
        numberOfLines = 0
    }
    
    func customizeDate(view: UIView, topView: UIView) {
        snp.makeConstraints { make in
            make.leading.equalTo(view).inset(30)
            make.top.equalTo(topView.snp.bottom).inset(-30)
            make.width.equalTo(200)
        }
        
        text = "Дата покупки:"
    }
}

