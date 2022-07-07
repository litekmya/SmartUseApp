//
//  RegistrationViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    //MARK: - Private properties
    private let contentView = RegistrationView()
    private var viewModel: RegistrationViewModelProtocol!
        
    //MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        customizeUI()
        addTarget()
        addDelegate()
        
        viewModel = RegistrationViewModel()
    }
    
    //MARK: - Private Methods
    private func customizeUI() {
        view.addSubview(contentView)
        view.backgroundColor = .white
        contentView.frame = view.frame
    }
    
    private func addDelegate() {
        contentView.emailTextField.delegate = self
        contentView.firstPassTextField.delegate = self
        contentView.secondPassTextField.delegate = self
    }
    
    private func addTarget() {
        contentView.registrationButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        
        contentView.emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        contentView.firstPassTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        contentView.secondPassTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func checkPasswords() -> Bool {
        guard let text = contentView.emailTextField.text else { return false }
        
        if contentView.firstPassTextField.text != contentView.secondPassTextField.text {
            reportAnError(text: ErrorText.passRegError.rawValue)
            print("Пароли не совпадают")
            return false
        } else if contentView.firstPassTextField.text?.count ?? 0 < 5 {
            reportAnError(text: ErrorText.incorrectPassError.rawValue)
            print("Пароль должен содержать не менее 6 знаков")
            return false
        } else if !text.contains("@") {
            reportAnError(text: ErrorText.emailRecoveryError.rawValue)
            print("Введен некоректный email адрес")
            return false
        } else {
            contentView.errorLabel.isHidden = true
            
            return true
        }
    }
    
    private func reportAnError(text: String) {
        contentView.errorLabel.text = text
        contentView.errorLabel.isHidden = false
        
        contentView.firstPassTextField.text = ""
        contentView.secondPassTextField.text = ""
    }
    
    //MARK: - @objc
    @objc private func registerUser() {
        if checkPasswords() {
            print("Пользователь пытается зарегистрироваться")
            viewModel.register(email: contentView.emailTextField.text ?? "", password: contentView.firstPassTextField.text ?? "")
        }
    }
    
    @objc private func textFieldDidChange() {
        if (contentView.emailTextField.text != "" && contentView.firstPassTextField.text != "" && contentView.secondPassTextField.text != "") {
            contentView.registrationButton.isEnabled = true
        } else {
            contentView.registrationButton.isEnabled = false
        }
    }
}

//MARK: - UItextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == contentView.emailTextField {
            contentView.emailTextField.resignFirstResponder()
            contentView.firstPassTextField.becomeFirstResponder()
        } else if textField == contentView.firstPassTextField {
            contentView.firstPassTextField.resignFirstResponder()
            contentView.secondPassTextField.becomeFirstResponder()
        } else {
            contentView.secondPassTextField.resignFirstResponder()
            registerUser()
        }
    
        return true
    }
}
