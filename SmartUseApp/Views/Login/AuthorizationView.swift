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
    
    let emailTextField: UITextField = {
        let field = UITextField()
        field.setupTextInput(placeholderText: "Email", contentType: .emailAddress, keyboard: .emailAddress)
        
        return field
    }()
    
    let passwordTextField: PasswordTextField = {
        let field = PasswordTextField()
        field.setup(keyType: .done)
        
        return field
    }()
    
    let logInButton: UIButton = {
        let button = UIButton()
        button.setup(title: Text.logInButtonTitle.rawValue, buttonIsEnabled: false)
        
        return button
    }()
    
    let forgotPassButton: UIButton = {
        let button = UIButton()
        button.setup(title: Text.forgotPassButonTitle.rawValue, buttonIsEnabled: true)
        
        return button
    }()
    
    let registrationButton: UIButton = {
        let button = UIButton()
        button.setup(title: Text.registrationButtonTitle.rawValue, buttonIsEnabled: true)
        
        return button
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.isHidden = true
        
        return label
    }()
    
    var signInWithAppleButton: ASAuthorizationAppleIDButton!
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .large
        
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeUI()
    }
    
    private func customizeUI() {
        backgroundColor = UIColor.lightOlive
        
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
        
        customizeImageView()
        customizeLabels()
        customizeTextFields()
        customizeButtons()
        customizeIndictor()
    }
    
    private func customizeImageView() {
        imageView.customize(from: self)
    }
    
    private func customizeLabels() {
        authLabel.customize(
            parrentView: self,
            topView: imageView,
            newText: Text.auth.rawValue,
            top: LabelsConstants.top.rawValue,
            left: LabelsConstants.left.rawValue
        )
        
        registrationLabel.customize(
            parrentView: self,
            topView: forgotPassButton,
            newText: Text.registratonLabelText.rawValue,
            top: LabelsConstants.top.rawValue,
            left: LabelsConstants.left.rawValue
        )
        
        errorLabel.customize(
            parrentView: self,
            topView: registrationButton,
            newText: Text.errorLabelText.rawValue,
            top: -15,
            left: LabelsConstants.left.rawValue
        )
    }
    
    private func customizeTextFields() {
        emailTextField.customize(topView: authLabel)
        passwordTextField.customizeLayout(topView: emailTextField)
    }
    
    private func customizeButtons() {
        logInButton.adjustOnAxisY(view: passwordTextField, top: ButtonConstants.centerTop.rawValue, bottom: nil)
        logInButton.customizeCenter(height: ButtonConstants.height.rawValue, width: ButtonConstants.wigth.rawValue)
        
        forgotPassButton.adjustOnAxisY(view: logInButton, top: ButtonConstants.centerTop.rawValue, bottom: nil)
        forgotPassButton.customizeCenter(height: ButtonConstants.height.rawValue, width: 250)
        
        registrationButton.adjustOnAxisY(view: registrationLabel, top: 8, bottom: nil)
        registrationButton.customizeCenter(height: ButtonConstants.height.rawValue, width: 250)
        
        signInWithAppleButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        addSubview(signInWithAppleButton)
        signInWithAppleButton.setupLayout(from: self)
    }
    
    private func customizeIndictor() {
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
    }
}
