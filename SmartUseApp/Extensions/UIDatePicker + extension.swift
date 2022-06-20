//
//  UIDatePicker + extension.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 16.06.2022.
//

import UIKit

extension UIDatePicker {
    
    func customize(datePicker: UIDatePicker, view: UIView, dateLabel: UILabel) {
        datePicker.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).inset(30)
            make.centerY.equalTo(dateLabel)
        }
        datePicker.datePickerMode = .date
    }
}
