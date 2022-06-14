//
//  NewObjectViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 27.05.2022.
//

import UIKit

protocol NewObjectViewControllerDelegate: AnyObject {
    func update(image: UIImage)
}

class NewObjectViewController: UIViewController, UINavigationControllerDelegate {
        
    //MARK: - Private properties
    private let imageView = UIImageView()
    private let nameTextField = UITextField()
    private let costTextField = UITextField()
    
    private var dateLabel = UILabel()
    private let datePicker = UIDatePicker()
    
    private var dismissButton: UIBarButtonItem!
    private var saveButton: UIBarButtonItem!
    private var addImageButton = UIButton()
    
    private var viewModel: NewObjectViewModelProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        addSubviews()
        customizeUI()
        
        viewModel = NewObjectViewModel()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print("viewDidAppear")
//    }
    
    //MARK: - Private methods
    private func customizeView() {
        view.backgroundColor = .white
        title = "someTitle"
    }
    
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(addImageButton)
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
            height: 150
        )
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        customizeTextFields()
        customizeDateObjects()
        setupButtons()
    }
    
    private func customizeTextFields() {
        nameTextField.customize(
            textField: nameTextField,
            view: imageView,
            placeholder: PlaceholderText.name.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        nameTextField.setupTextInput(nameTextField, contentType: .name, delegate: self)
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
        
        costTextField.customize(
            textField: costTextField,
            view: nameTextField,
            placeholder: PlaceholderText.cost.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        costTextField.setupTextInput(costTextField, contentType: .telephoneNumber, delegate: self)
        costTextField.keyboardType = .numberPad
        costTextField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
    }
    
    private func customizeDateObjects() {
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
    
    private func setupButtons() {
        addImageButton.snp.makeConstraints { make in
            make.center.equalTo(imageView)
            make.width.equalTo(ImageConstants.topAndHeight.rawValue)
            make.height.equalTo(ImageConstants.topAndHeight.rawValue)
        }
        addImageButton.addTarget(self, action: #selector(addImageButtonAction), for: .touchUpInside)
       
        dismissButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissButtonAction))
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonAction))
        saveButton.isEnabled = false
        
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = dismissButton
    }
    
    //MARK: - @objc
    @objc private func dismissButtonAction() {
        dismiss(animated: true)
    }
    
    @objc private func saveButtonAction() {
        print("Нажата кнопка сохранения")
        let dateInteger = datePicker.date.formatted()
        guard let imageData = imageView.image?.pngData() else {
            print("Не получилось преобразовать image")
            return }
        
        viewModel.save(
            name: nameTextField.text ?? "",
            cost: costTextField.text ?? "",
            date: dateInteger, urlString: "",
            imageData: imageData
        )
        
        
        self.dismiss(animated: true)
    }
    
    @objc private func addImageButtonAction() {
        print("Нажата кнопка добавления картинки")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)

        let addedVC = AddedImageCollectionViewController(collectionViewLayout: layout)
        addedVC.accessibilityNavigationStyle = .separate
        addedVC.delegate = self

        present(addedVC, animated: true)
    }
    
    @objc func textFieldDidChange() {
        if nameTextField.text != "" && costTextField.text != "" {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

//MARK: - NewObjectViewControllerDelegate
extension NewObjectViewController: NewObjectViewControllerDelegate {
    
    func update(image: UIImage) {
        print(image.size)
        imageView.image = image
        print("delegate сработал")
    }
}

//MARK: - UITextFieldDelegate
extension NewObjectViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
