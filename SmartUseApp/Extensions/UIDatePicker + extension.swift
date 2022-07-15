//
//  UIDatePicker + extension.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 16.06.2022.
//

import UIKit

extension UIDatePicker {
    
    func customize(parentView: UIView, dateLabel: UILabel) {
        snp.makeConstraints { make in
            make.trailing.equalTo(parentView.snp.trailing).inset(30)
            make.centerY.equalTo(dateLabel)
        }
        datePickerMode = .date
    }
}
