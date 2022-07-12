//
//  AuthorizationView.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 03.07.2022.
//

import UIKit
import AuthenticationServices

class AuthorizationView: UIView {
    
    let imageView = UIImageView()
    let authLabel = UILabel()
    let registrationLabel = UILabel()
    
    let emailTextField = UITextField()
    let passwordTextField: PasswordTextField = {
        let field = PasswordTextField()
        field.setup(keyType: .done)
        
        return field
    }()
    
    let logInButton = UIButton()
    let forgotPassButton = UIButton()
    let registrationButton = UIButton()
    let errorLabel = UILabel()
    var signInWithAppleButton: ASAuthorizationAppleIDButton!
    
    var activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeUI()
    }
    
    private func customizeUI() {
        addSubview(imageView)
        addSubview(authLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(logInButton)
        addSubview(forgotPassButton)
        addSubview(registrationButton)
        addSubview(registrationLabel)
        addSubview(errorLabel)
        addSubview(activityIndicator)
        
        imageView.customize(
            imageView: imageView,
            view: self,
            top: ImageConstants.topAndHeight.rawValue,
            height: ImageConstants.topAndHeight.rawValue
        )
        
        authLabel.customize(
            label: authLabel,
            parrentView: self,
            topView: imageView,
            text: Text.auth.rawValue,
            top: LabelsConstants.top.rawValue,
            left: LabelsConstants.left.rawValue
        )
        
        emailTextField.customize(
            textField: emailTextField,
            view: authLabel,
            placeholder: PlaceholderText.email.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        emailTextField.setupTextInput(emailTextField, contentType: .emailAddress)
        
        passwordTextField.customizeLayout(topView: emailTextField)
        
        logInButton.setup(
            button: logInButton,
            title: Text.logInButtonTitle.rawValue,
            isEnabled: false
        )
        
        logInButton.customizeCenter(
            button: logInButton,
            height: ButtonConstants.height.rawValue,
            width: ButtonConstants.wigth.rawValue
        )
        
        logInButton.adjust(
            button: logInButton,
            view: passwordTextField,
            top: ButtonConstants.centerTop.rawValue,
            bottom: nil
        )
        
        forgotPassButton.setup(
            button: forgotPassButton,
            title: Text.forgotPassButonTitle.rawValue,
            isEnabled: true
        )
        
        forgotPassButton.customizeCenter(
            button: forgotPassButton,
            height: ButtonConstants.height.rawValue,
            width: 250
        )
        
        forgotPassButton.adjust(
            button: forgotPassButton,
            view: logInButton,
            top: ButtonConstants.centerTop.rawValue,
            bottom: nil
        )
        
        registrationLabel.customize(
            label: registrationLabel,
            parrentView: self,
            topView: forgotPassButton,
            text: Text.registratonLabelText.rawValue,
            top: LabelsConstants.top.rawValue,
            left: LabelsConstants.left.rawValue
        )
        
        registrationButton.setup(
            button: registrationButton,
            title: Text.registrationButtonTitle.rawValue,
            isEnabled: true
        )
        
        registrationButton.customizeCenter(
            button: registrationButton,
            height: ButtonConstants.height.rawValue,
            width: 250
        )
        
        registrationButton.adjust(button: registrationButton, view: registrationLabel, top: 8, bottom: nil)
        
        errorLabel.customize(
            label: errorLabel,
            parrentView: self,
            topView: registrationButton,
            text: Text.errorLabelText.rawValue,
            top: -15,
            left: LabelsConstants.left.rawValue
        )
        errorLabel.textColor = .red //Скрыть
        
        signInWithAppleButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        addSubview(signInWithAppleButton)
        signInWithAppleButton.setupLayout(button: signInWithAppleButton, with: self)
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
    }
}
