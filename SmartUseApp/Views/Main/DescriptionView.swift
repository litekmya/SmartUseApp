//
//  DescriptionView.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 03.07.2022.
//

import UIKit

class DescriptionView: UIView {
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        
        return button
    }()
    
    let titleLabel = UILabel()
    
    let imageView = UIImageView()
    let costLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "Дата покупки:"
        
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.locale = Locale.autoupdatingCurrent
        picker.datePickerMode = .date
        
        return picker
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнее", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeUI()
    }
    
    private func customizeUI() {
        backgroundColor = UIColor.lightOlive
        
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(costLabel)
        addSubview(dateLabel)
        addSubview(datePicker)
        addSubview(moreButton)
        
        customizeButtons()
        customizeImageView()
        customizeLabels()
        customizeDatePicker()
    }
    
    private func customizeImageView() {
        imageView.customizeWithoutBar(topView: titleLabel, parrentView: self)
    }
    
    private func customizeLabels() {
        titleLabel.customizeLayoutWithTitle(topView: backButton, parrentView: self)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.left.equalTo(self).inset(30)
        }
        
        costLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(30)
            make.centerX.equalTo(self)
        }
    }
    
    private func customizeDatePicker() {
        datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.trailing.equalTo(self).inset(30)
        }
    }
    
    private func customizeButtons() {
        backButton.customizeLeftBarButton(parentView: self)
        
        moreButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(costLabel.snp.bottom).offset(30)
            make.bottom.equalTo(self).inset(16)
        }
    }
}
