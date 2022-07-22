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

class NewObjectViewController: UIViewController {
    
    var viewModel: NewObjectViewModelProtocol!
            
    //MARK: - Private properties
    private let contentView = NewObjectView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NewObjectViewModel()
        customizeUI()
    }
    
    //MARK: - Private methods
    private func customizeUI() {
        title = "Не забудь выбрать картинку"
        view.backgroundColor = UIColor.lightOlive
        view.addSubview(contentView)
        
        customizeContentView()
        addTargetsAndDelegates()
    }
    
    private func customizeContentView() {
        contentView.frame = view.frame
    }
    
    private func addTargetsAndDelegates() {
        contentView.backButton.addTarget(self, action: #selector(dismissButtonAction), for: .touchUpInside)
        contentView.saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        contentView.saveButton.isEnabled = false
        
        contentView.addImageButton.addTarget(self, action: #selector(addImageButtonAction), for: .touchUpInside)
        contentView.nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        contentView.costTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        contentView.nameTextField.delegate = self
        contentView.costTextField.delegate = self
    }
    
    //MARK: - @objc
    @objc private func dismissButtonAction() {
        dismiss(animated: true)
    }
    
    @objc private func saveButtonAction() {
        let formatter = CustomDateFormatter()
        let dateString = formatter.convertToString(date: contentView.datePicker.date)
        
        guard let imageData = contentView.imageView.image?.pngData() else { return }
        guard let name = contentView.nameTextField.text else { return }
        guard let cost = contentView.costTextField.text else { return }

        viewModel.save(name: name, cost: cost, date: dateString, urlString: "", imageData: imageData)

        self.dismiss(animated: true)
    }
    
    @objc private func addImageButtonAction() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)

        let addedVC = AddedImageCollectionViewController(collectionViewLayout: layout)
        addedVC.accessibilityNavigationStyle = .separate
        addedVC.delegate = self

        present(addedVC, animated: true)
    }
    
    @objc func textFieldDidChange() {
        let isEnabled = viewModel.checkFieldsForFullness(
            name: contentView.nameTextField.text ?? "",
            cost: contentView.costTextField.text ?? ""
        )
        contentView.saveButton.isEnabled = isEnabled
    }
}

//MARK: - NewObjectViewControllerDelegate
extension NewObjectViewController: NewObjectViewControllerDelegate {
    
    func update(image: UIImage) {
        contentView.imageView.image = image
    }
}

//MARK: - UITextFieldDelegate
extension NewObjectViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == contentView.nameTextField {
            contentView.nameTextField.resignFirstResponder()
            contentView.costTextField.becomeFirstResponder()
        }
        
        return true
    }
}
