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
    
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    
    private let loginButton = UIButton()
    private let registrationButton = UIButton()
    private let errorLabel = UILabel()
    private let signInWithAppleButton = UIButton()
    
    private let authTitle = "Авторизация"
    private let loginPlaceholder = "Login"
    private let passPlaceholder = "Password"
    private let loginButtonTitle = "Войти"
    private let registratonLabelText = "Если у вас нет действующего аккаунта, то вы можете"
    private let registrationButtonTitle = "Зарегистрироваться здесь"
    private let errorLabelText = "Введен неверный логин и/или пароль"
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        customizeUI()
        
        loginButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(goToRegistration), for: .touchUpInside)
    }
    
    //MARK: - Private methods
    private func customizeUI() {
        view.addSubview(imageView)
        view.addSubview(authLabel)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(signInWithAppleButton)
        view.addSubview(registrationButton)
        view.addSubview(registrationLabel)
        view.addSubview(errorLabel)

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
        
        loginTextField.customize(textField: loginTextField, view: authLabel, placeholder: loginPlaceholder,top: TextFieldConstants.top.rawValue, left: TextFieldConstants.left.rawValue)
        passwordTextField.customize(textField: passwordTextField, view: loginTextField, placeholder: passPlaceholder,top: 20, left: 50)
        
        loginButton.setup(button: loginButton, title: loginButtonTitle , isEnabled: false)
        loginButton.customizeCenter(button: loginButton, view: passwordTextField, height: 48, width: 127)
        loginButton.adjust(button: loginButton, view: passwordTextField, top: -20, bottom: nil)
        
        registrationLabel.customize(label: registrationLabel, view: loginButton, text: registratonLabelText, top: -35, left: 20)
        
        registrationButton.setup(button: registrationButton, title: registrationButtonTitle, isEnabled: true)
        registrationButton.customizeCenter(button: registrationButton, view: view, height: 48, width: 250)
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
        signInWithAppleButton.adjust(button: signInWithAppleButton, view: view, top: nil, bottom: 40)
        signInWithAppleButton.adjust(button: signInWithAppleButton, view: view, leading: 45, trailing: 45)
    }
    
    @objc private func logIn() {
        // Переход на другой экран, если логин и пароль верны
        print("Log in")
    }
    
    @objc private func goToRegistration() {
        // Переход на экран регистрации
        print("Registration")
        
        let registrationVC = RegistrationViewController()
        present(registrationVC, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension AuthorizationViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

