//
//  NewObjectViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 27.05.2022.
//

import UIKit

class NewObjectViewController: UIViewController {
    
    //MARK: - Private properties
    private let imageView = UIImageView()
    private let nameTextField = UITextField()
    private let costTextField = UITextField()
    
    private var dateLabel = UILabel()
    private let datePicker = UIDatePicker()
    
    private var exitButton: UIBarButtonItem!
    private var saveButton: UIBarButtonItem!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        title = "someTitle"

        addSubviews()
        customizeUI()
    }
    
    //MARK: - Private methods
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(nameTextField)
        view.addSubview(costTextField)
        view.addSubview(dateLabel)
        view.addSubview(datePicker)
    }
    
    private func customizeUI() {
        imageView.customize(
            imageView: imageView,
            view: view,
            top: 180,
            height: ImageConstants.topAndHeight.rawValue
        )
        
        customizeTextFields()
        someAction()
        setupBarButtonItems()
    }
    
    private func customizeTextFields() {
        nameTextField.customize(
            textField: nameTextField,
            view: imageView,
            placeholder: PlaceholderText.name.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        
        costTextField.customize(
            textField: costTextField,
            view: nameTextField,
            placeholder: PlaceholderText.cost.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        costTextField.keyboardType = .numberPad
    }
    
    private func someAction() {
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(view).inset(30)
            make.top.equalTo(costTextField.snp.bottom).inset(-30)
            make.width.equalTo(200)
        }
        dateLabel.text = "Дата покупки:"
        
        datePicker.snp.makeConstraints { make in
            make.right.equalTo(view).inset(30)
            make.centerY.equalTo(dateLabel)
        }
        datePicker.datePickerMode = .date
    }
    
    private func setupBarButtonItems() {
        exitButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(exitButtonAction))
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonItem))
        
        navigationItem.leftBarButtonItem = exitButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    //MARK: - @objc
    @objc private func exitButtonAction() {
        dismiss(animated: true)
    }
    
    @objc private func saveButtonItem() {
        print("Нажата кнопка сохранения")
    }
}
