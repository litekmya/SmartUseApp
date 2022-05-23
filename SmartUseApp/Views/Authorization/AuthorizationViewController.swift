//
//  RegistrationViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 18.05.2022.
//

import UIKit
import SnapKit

class AuthorizationViewController: UIViewController {
    
    //MARK: - Private properties
    private let imageView = UIImageView()
    private let authLabel = UILabel()
    private let registrationLabel = UILabel()
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    
    private let loginButton = UIButton()
    private let registrationButton = UIButton()
    private let errorLabel = UILabel()
    private let signInWithAppleButton = UIButton()
    
    private var activityIndicator = UIActivityIndicatorView()
    
    private let authTitle = "Авторизация"
    private let loginButtonTitle = "Войти"
    private let registratonLabelText = "Если у вас нет действующего аккаунта, то вы можете"
    private let registrationButtonTitle = "Зарегистрироваться здесь"
    private let errorLabelText = "Введен неверный email и/или пароль"
        
    private var viewModel: AuthorizationViewModelProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        customizeUI()
        addTarget()
        
        errorLabel.isHidden = true
        
        viewModel = AuthorizationViewModel(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    //MARK: - Private methods
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(authLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(signInWithAppleButton)
        view.addSubview(registrationButton)
        view.addSubview(registrationLabel)
        view.addSubview(errorLabel)
        view.addSubview(activityIndicator)
    }
    
    private func customizeUI() {
        imageView.customize(
            imageView: imageView,
            view: self.view,
            top: ImageConstants.topAndHeight.rawValue,
            height: ImageConstants.topAndHeight.rawValue
        )
        
        authLabel.customize(
            label: authLabel,
            view: imageView,
            text: authTitle,
            top: LabelsConstants.top.rawValue,
            left: LabelsConstants.left.rawValue
        )
        
        emailTextField.customize(
            textField: emailTextField,
            view: authLabel,
            placeholder: Text.login.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        emailTextField.setupTextInput(emailTextField, contentType: .emailAddress, delegate: self)
        
        passwordTextField.customize(
            textField: passwordTextField,
            view: emailTextField,
            placeholder: Text.password.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        passwordTextField.setupTextInput(passwordTextField, contentType: .password, delegate: self)
        
        loginButton.setup(button: loginButton, title: loginButtonTitle , isEnabled: false)
        
        loginButton.customizeCenter(
            button: loginButton,
            view: passwordTextField,
            height: ButtonConstants.height.rawValue,
            width: ButtonConstants.wigth.rawValue
        )
        
        loginButton.adjust(
            button: loginButton,
            view: passwordTextField,
            top: ButtonConstants.centerTop.rawValue,
            bottom: nil
        )
        
        registrationLabel.customize(
            label: registrationLabel,
            view: loginButton,
            text: registratonLabelText,
            top: LabelsConstants.top.rawValue,
            left: LabelsConstants.left.rawValue
        )
        
        registrationButton.setup(button: registrationButton, title: registrationButtonTitle, isEnabled: true)
        
        registrationButton.customizeCenter(
            button: registrationButton,
            view: view,
            height: ButtonConstants.height.rawValue,
            width: 250
        )
        
        registrationButton.adjust(button: registrationButton, view: registrationLabel, top: 8, bottom: nil)
        
        errorLabel.customize(
            label: errorLabel,
            view: registrationButton,
            text: errorLabelText,
            top: LabelsConstants.top.rawValue,
            left: LabelsConstants.left.rawValue
        )
        errorLabel.textColor = .red //Скрыть
        
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
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
    }
    
    private func addTarget() {
        loginButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(goToRegistration), for: .touchUpInside)
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    //MARK: - @objc funcs
    @objc private func logIn() {
        print("Пользователь пытается авторизоваться")
        self.activityIndicator.startAnimating()
        
        self.viewModel.logIn(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "") { error in
            
            if error == nil {
                let welcomeVC = WelcomeViewController()
                self.present(welcomeVC, animated: true)
            } else {
                self.errorLabel.isHidden = false
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    @objc private func goToRegistration() {
        // Переход на экран регистрации
        print("Registration")
        
        let registrationVC = RegistrationViewController()
        present(registrationVC, animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if (emailTextField.text != "" && passwordTextField.text != "") {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
}

//MARK: - UITextFieldDelegate
extension AuthorizationViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else {
            logIn()
        }
        
        return true
    }
}

