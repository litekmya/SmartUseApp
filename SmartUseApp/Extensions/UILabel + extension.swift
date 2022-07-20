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
    
    func customizeLayoutWithTitle(topView: UIView, parrentView: UIView) {
        snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(16)
            make.leading.equalTo(parrentView).inset(30)
        }
    }
    
    func customizeAppearanceWith(title: String) {
        font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        text = title
        // Добавить цвет текста
    }
    
    func customizeStaticStatisticsLabel(parentView: UIView, topView: UIView, left: Bool) {
        snp.makeConstraints { make in
            
            make.top.equalTo(topView.snp.bottom).offset(16)
            make.bottom.equalTo(parentView.snp.centerY).inset(4)
            
            checkSide(left: left)
        }
    }
    
    func customizeStatisticsLabel(parentView: UIView, left: Bool) {
        snp.makeConstraints { make in
            make.top.equalTo(parentView.snp.centerY).offset(4)
            make.bottom.equalTo(parentView).inset(8)
            
            checkSide(left: left)
        }
    }
    
    private func checkSide(left: Bool) {
        snp.makeConstraints { make in
            if left {
                make.leading.equalToSuperview().inset(8)
            } else {
                make.trailing.equalToSuperview().inset(8)
            }
        }
    }
}

