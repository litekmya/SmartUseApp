//
//  NewObjectView.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 15.07.2022.
//

import UIKit

class NewObjectView: UIView {
    
    let imageView = UIImageView()
    let nameTextField = UITextField()
    let costTextField = UITextField()
    
    var dateLabel = UILabel()
    let datePicker = UIDatePicker()

    var addImageButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeUI()
    }
    
    private func customizeUI() {
        addSubview(imageView)
        addSubview(nameTextField)
        addSubview(costTextField)
        addSubview(dateLabel)
        addSubview(datePicker)
        addSubview(addImageButton)
        
        customizeImageView()
        customizeTextFields()
        customizeDateObjects()
        customizeButton()
    }
    
    private func customizeImageView() {
        imageView.customize(from: self)
        imageView.image = UIImage(named: "icon8")
    }
    
    private func customizeTextFields() {
        nameTextField.customize(topView: imageView)
        nameTextField.setupTextInput(placeholderText: "Name", contentType: .name, keyboard: .namePhonePad)
        
        costTextField.customize(topView: nameTextField)
        costTextField.setupTextInput(placeholderText: "Цена", contentType: .telephoneNumber, keyboard: .numberPad)
    }
    
    private func customizeDateObjects() {
        dateLabel.customizeDate(view: self, topView: costTextField)
        
        datePicker.customize(parentView: self, dateLabel: dateLabel)
    }
    
    private func customizeButton() {
        addImageButton.snp.makeConstraints { make in
            make.top.equalTo(imageView)
            make.centerX.equalTo(imageView)
            make.height.width.equalTo(imageView)
        }
    }
}
