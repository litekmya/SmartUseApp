//
//  RegistrationView.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 03.07.2022.
//
import UIKit
import AuthenticationServices

class RegistrationView: UIView {
    
    let imageView = UIImageView()
    let registrationLabel = UILabel()
    
    let emailTextField = UITextField()
    let firstPassTextField: PasswordTextField = {
        let field = PasswordTextField()
        field.setup(keyType: .next)
        
        return field
    }()
    
    let secondPassTextField: PasswordTextField = {
        let field = PasswordTextField()
        field.setup(keyType: .done)
        
        return field
    }()
    
    let registrationButton: UIButton = {
        let button = UIButton()
        button.customizeCenter(height: ButtonConstants.height.rawValue, width: ButtonConstants.wigth.rawValue)
        button.setup(title: Text.registration.rawValue, buttonIsEnabled: false)
        
        return button
    }()
    var signInWithAppleButton: ASAuthorizationAppleIDButton!
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.isHidden = true
        
        return label
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
        addSubview(imageView)
        addSubview(registrationLabel)
        addSubview(emailTextField)
        addSubview(firstPassTextField)
        addSubview(secondPassTextField)
        addSubview(registrationButton)
        addSubview(errorLabel)
        
        customizeImageView()
        customizeLabels()
        customizeTextFields()
        customizeButtons()
    }
    
    private func customizeImageView() {
        imageView.customize(from: self)
    }
        
    private func customizeLabels() {
        registrationLabel.customize(
                parrentView: self,
                topView: imageView,
                newText: Text.regText.rawValue,
                top: LabelsConstants.top.rawValue,
                left: LabelsConstants.left.rawValue
        )
        
        errorLabel.customize(
            parrentView: self,
            topView: registrationButton,
            newText: ErrorText.passRegError.rawValue,
            top: LabelsConstants.errorTop.rawValue,
            left: LabelsConstants.errorLeft.rawValue
        )
    }
    
    private func customizeTextFields() {
        emailTextField.customize(topView: registrationLabel)
        firstPassTextField.customizeLayout(topView: emailTextField)
        secondPassTextField.customizeLayout(topView: firstPassTextField)
    }
    
    private func customizeButtons() {
        registrationButton.adjustOnAxisY(view: secondPassTextField, top: ButtonConstants.centerTop.rawValue, bottom: nil)
        
        signInWithAppleButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signUp, authorizationButtonStyle: .black)
        addSubview(signInWithAppleButton)
        signInWithAppleButton.setupLayout(from: self)
    }
}
