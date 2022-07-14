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
        
        contentView.firstPassTextField.showPassButton.addTarget(self, action: #selector(showPassForFirstField), for: .touchUpInside)
        contentView.secondPassTextField.showPassButton.addTarget(self, action: #selector(showPassForSecondField), for: .touchUpInside)
    }
    
    private func checkPasswords() -> (Bool) {
        guard let email = contentView.emailTextField.text else { return false }
        guard let firstPass = contentView.firstPassTextField.text else { return false }
        guard let secondPass = contentView.secondPassTextField.text else { return false }
        var passedExam = true
        
        viewModel.check(email: email) { result in
            switch result {
            case .success: break
            case .failure(let error):
                self.reportAnError(text: error.localizedDescription)
                passedExam = false
            }
        }
        
        viewModel.check(password: firstPass) { result in
            switch result {
            case .success: break
            case .failure(let error):
                self.reportAnError(text: error.localizedDescription)
                passedExam = false
            }
        }
        
        viewModel.checkForIdentity(firstPass: firstPass, secondPass: secondPass) { result in
            switch result {
            case .success: break
            case .failure(let error):
                self.reportAnError(text: error.localizedDescription)
                passedExam = false
            }
        }
        
        return passedExam
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
            viewModel.register(email: contentView.emailTextField.text ?? "", password: contentView.firstPassTextField.text ?? "") { authResult in
                    
            }
        }
    }
    
    @objc private func textFieldDidChange() {
        let isEnabled = viewModel.checkFieldsForFullness(
            email: contentView.emailTextField.text ?? "",
            fisrtPass: contentView.firstPassTextField.text ?? "",
            secondPass: contentView.secondPassTextField.text ?? "")
        
        contentView.registrationButton.isEnabled = isEnabled
    }
    
    @objc private func showPassForFirstField() {
        contentView.firstPassTextField.changeImageForButton()
    }
    
    @objc private func showPassForSecondField() {
        contentView.secondPassTextField.changeImageForButton()
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
