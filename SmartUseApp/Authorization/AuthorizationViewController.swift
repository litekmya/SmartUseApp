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
    private var imageView = UIImageView()
    private var authLabel = UILabel()
    private let registrationLabel = UILabel()
    
    private var loginTextField = UITextField()
    private var passwordTextField = UITextField()
    
    private var loginButton = UIButton()
    private var registrationButton = UIButton()
    private var signInWithAppleButton = UIButton()
    
    private let authTitle = "Авторизация"
    private let loginPlaceholder = "Login"
    private let passPlaceholder = "Password"
    private let loginButtonTitle = "Войти"
    private let registratonLabelText = "Если у вас нет действующего аккаунта, то вы можете"
    private let registrationButtonTitle = "Зарегистрироваться здесь"
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        customizeUI()
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

        imageView.customize(imageView: imageView, view: self.view, top: 90, height: 90)
        authLabel.customize(label: authLabel, view: imageView, text: authTitle, top: -35, left: 20)
        
        loginTextField.customize(textField: loginTextField, view: authLabel, placeholder: loginPlaceholder,top: 20, left: 50)
        passwordTextField.customize(textField: passwordTextField, view: loginTextField, placeholder: passPlaceholder,top: 20, left: 50)
        
        loginButton.setup(button: loginButton, title: loginButtonTitle , isEnabled: false)
        loginButton.customizeCenter(button: loginButton, view: passwordTextField, height: 48, width: 127)
        loginButton.adjust(button: loginButton, view: passwordTextField, top: -20, bottom: nil)
        
        registrationLabel.customize(label: registrationLabel, view: loginButton, text: registratonLabelText, top: -35, left: 20)
        
        registrationButton.setup(button: registrationButton, title: registrationButtonTitle, isEnabled: true)
        registrationButton.customizeCenter(button: registrationButton, view: view, height: 48, width: 250)
        registrationButton.adjust(button: registrationButton, view: registrationLabel, top: 8, bottom: nil)
        
        signInWithAppleButton.customizeByAppleSign(button: signInWithAppleButton)
        signInWithAppleButton.adjust(button: signInWithAppleButton, view: view, top: nil, bottom: 40)
        signInWithAppleButton.adjust(button: signInWithAppleButton, view: view, leading: 45, trailing: 45)
    }
    
    private func customize(imageView: UIImageView, view: UIView) {
        imageView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.height.width.equalTo(90)
            maker.top.equalToSuperview().inset(90)
        }
        
        imageView.layer.cornerRadius = 45
        imageView.backgroundColor = .blue
    }
}

