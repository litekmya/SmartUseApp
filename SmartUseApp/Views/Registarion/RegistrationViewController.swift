//
//  RegistrationViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    //MARK: - Private properties
    private let imageView = UIImageView()
    private let registrationLabel = UILabel()
    
    private let emailTextField = UITextField()
    private let firstPassTextField = UITextField()
    private let secondPassTextField = UITextField()
    
    private let registrationButton = UIButton()
    private let signInWithAppleButton = UIButton()
    
    private let errorLabel = UILabel()
    
    private var viewModel: RegistrationViewModelProtocol!
        
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        customizeUI()
        addTarget()
        changeViewModel()
    }
    
    //MARK: - Private Methods
    private func customizeUI() {
        view.addSubview(imageView)
        view.addSubview(registrationLabel)
        view.addSubview(emailTextField)
        view.addSubview(firstPassTextField)
        view.addSubview(secondPassTextField)
        view.addSubview(registrationButton)
        view.addSubview(errorLabel)
        view.addSubview(signInWithAppleButton)
        
        imageView.customize(
            imageView: imageView,
            view: view,
            top: ImageConstants.topAndHeight.rawValue,
            height: ImageConstants.topAndHeight.rawValue
        )
        
        registrationLabel.customize(
            label: registrationLabel,
            view: imageView,
            text: Text.regText.rawValue,
            top: LabelsConstants.top.rawValue,
            left: LabelsConstants.left.rawValue
        )
        
        emailTextField.customize(
            textField: emailTextField,
            view: registrationLabel,
            placeholder: Text.login.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        emailTextField.setupTextInput(emailTextField, contentType: .emailAddress, delegate: self)
        
        firstPassTextField.customize(
            textField: firstPassTextField,
            view: emailTextField,
            placeholder: Text.password.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        firstPassTextField.setupTextInput(firstPassTextField, contentType: .password, delegate: self)
        
        secondPassTextField.customize(
            textField: secondPassTextField,
            view: firstPassTextField,
            placeholder: Text.password.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        secondPassTextField.setupTextInput(secondPassTextField, contentType: .password, delegate: self)
        
        registrationButton.customizeCenter(
            button: registrationButton,
            view: secondPassTextField,
            height: ButtonConstants.height.rawValue,
            width: ButtonConstants.wigth.rawValue
        )
        
        registrationButton.setup(
            button: registrationButton,
            title: Text.registration.rawValue,
            isEnabled: false
        )
        
        registrationButton.adjust(
            button: registrationButton,
            view: secondPassTextField,
            top: ButtonConstants.centerTop.rawValue,
            bottom: nil
        )
        
        errorLabel.customize(
            label: errorLabel,
            view: registrationButton,
            text: Text.passRegError.rawValue,
            top: LabelsConstants.errorTop.rawValue,
            left: LabelsConstants.errorLeft.rawValue
        )
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        
        signInWithAppleButton.customizeByAppleSign(button: signInWithAppleButton)
        
        signInWithAppleButton.adjust(
            button: signInWithAppleButton,
            view: view,
            top: nil,
            bottom: ButtonConstants.bottom.rawValue
        )
        
        signInWithAppleButton.adjust(
            button: signInWithAppleButton,
            view: view,
            leading: ButtonConstants.leadingAndTrailing.rawValue,
            trailing: ButtonConstants.leadingAndTrailing.rawValue
        )
    }
    
    private func addTarget() {
        registrationButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        firstPassTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        secondPassTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func checkPasswords() -> Bool {
        if firstPassTextField.text != secondPassTextField.text {
            errorLabel.text = Text.passRegError.rawValue
            errorLabel.isHidden = false
            
            print("Пароли не совпадают")
            
            return false
        } else {
            errorLabel.isHidden = true
            
            return true
        }
    }
    
    private func changeViewModel() {
        viewModel = RegistrationViewModel(authModel: getData())
        viewModel.viewModelDidChange = { [unowned self] viewModel in
//            viewModel.email = emailTextField.text ?? ""
//            viewModel.password =  firstPassTextField.text ?? ""
            self.emailTextField.text = viewModel.email
            self.firstPassTextField.text = viewModel.password
            print(viewModel.email)

        }
    }
    
    private func getData() -> AuthModel {
        let authModel = AuthModel(email: emailTextField.text ?? "", password: firstPassTextField.text ?? "")
//        viewModel = RegistrationViewModel(authModel: authModel)
//        print(viewModel.email)
        return authModel
    }
    
    //MARK: - @objc
    @objc private func registerUser() {
        if checkPasswords() {
            print("Пользователь был зарегистрирован")
//            getData()
            viewModel.transferData(auth: getData())
        }
        
    }
    
    @objc private func textFieldDidChange() {
        if (emailTextField.text != "" && firstPassTextField.text != "" && secondPassTextField.text != "") {
            registrationButton.isEnabled = true
        } else {
            registrationButton.isEnabled = false
        }
    }
}

//MARK: - UItextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            emailTextField.resignFirstResponder()
            firstPassTextField.becomeFirstResponder()
        } else if textField == firstPassTextField {
            firstPassTextField.resignFirstResponder()
            secondPassTextField.becomeFirstResponder()
        } else {
            registerUser()
//            getData()
        }
    
        return true
    }
}
