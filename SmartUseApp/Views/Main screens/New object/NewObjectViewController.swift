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
    
    private var exitButton: UIBarButtonItem!
    private var saveButton: UIBarButtonItem!
    
    private var addImageButton = UIButton()
    
    private var viewModel: NewObjectViewModelProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        title = "someTitle"
        
        addSubviews()
        customizeUI()
        
        viewModel = NewObjectViewModel()
    }
    
    //MARK: - Private methods
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
            height: ImageConstants.topAndHeight.rawValue
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
        
        costTextField.customize(
            textField: costTextField,
            view: nameTextField,
            placeholder: PlaceholderText.cost.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        costTextField.keyboardType = .numberPad
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
        let dateInteger = datePicker.date.formatted()
        guard let imageData = imageView.image?.pngData() else {
            print("Не получилось преобразовать image")
            return }
        
        viewModel.save(name: nameTextField.text ?? "", cost: costTextField.text ?? "", date: dateInteger, imageURL: "", imageData: imageData)
        dismiss(animated: true)
    }
    
    @objc private func addImageButtonAction() {
        print("Нажата кнопка добавления картинки")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
//        let addedVC = UINavigationController(rootViewController: AddedImageCollectionViewController(collectionViewLayout: layout))
//        addedVC.delegate = self
//
//        present(addedVC, animated: true)
        let addedVC = AddedImageCollectionViewController(collectionViewLayout: layout)
//        addedVC.modalPresentationStyle = .fullScreen
        addedVC.accessibilityNavigationStyle = .separate
        addedVC.delegate = self
//        navigationController?.pushViewController(addedVC, animated: true)
        present(addedVC, animated: true)
    }
}

extension NewObjectViewController: NewObjectViewControllerDelegate {
    
    func update(image: UIImage) {
        imageView.image = image
        print("delegate сработал")
    }
}
