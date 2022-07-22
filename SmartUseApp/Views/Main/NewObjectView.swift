//
//  NewObjectView.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 15.07.2022.
//

import UIKit

class NewObjectView: UIView {
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checkMark"), for: .normal)
        
        return button
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon8")
        
        return view
    }()
    
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
        backgroundColor = UIColor.olive
        
        addSubview(backButton)
        addSubview(saveButton)
        addSubview(imageView)
        addSubview(nameTextField)
        addSubview(costTextField)
        addSubview(dateLabel)
        addSubview(datePicker)
        addSubview(addImageButton)
        
        customizeButtons()
        customizeImageView()
        customizeTextFields()
        customizeDateObjects()
    }
    
    private func customizeButtons() {
        backButton.customizeLeftBarButton(parentView: self)
        saveButton.customizeRightBarButton(parentView: self)
        
        addImageButton.snp.makeConstraints { make in
            make.top.equalTo(imageView)
            make.centerX.equalTo(imageView)
            make.height.width.equalTo(imageView)
        }
    }
    
    private func customizeImageView() {
        imageView.customizeWithoutBar(topView: backButton, parrentView: self)
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
    
    
}
