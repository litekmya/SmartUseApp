//
//  UIImageView + extension.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 19.05.2022.
//

import UIKit
import SnapKit

extension UIImageView {
    
    func customize(imageView: UIImageView, view: UIView, top: Int, height: Int) {
        imageView.snp.makeConstraints { maker in
            maker.centerX.equalTo(view)
            maker.height.width.equalTo(height)
            maker.top.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        imageView.layer.cornerRadius = CGFloat(height / 2)
        imageView.backgroundColor = .blue
    }
}
