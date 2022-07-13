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
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.height.width.equalTo(height)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        imageView.layer.cornerRadius = CGFloat(height / 2)
//        imageView.backgroundColor = .blue
    }
}
