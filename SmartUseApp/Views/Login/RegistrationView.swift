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
    
    let registrationButton = UIButton()
    var signInWithAppleButton: ASAuthorizationAppleIDButton!
    
    let errorLabel = UILabel()
    
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
        
        imageView.customize(
            imageView: imageView,
            view: self,
            top: ImageConstants.topAndHeight.rawValue,
            height: ImageConstants.topAndHeight.rawValue
        )
        
        registrationLabel.customize(
            label: registrationLabel,
            parrentView: self,
            topView: imageView,
            text: Text.regText.rawValue,
            top: LabelsConstants.top.rawValue,
            left: LabelsConstants.left.rawValue
        )
        
        emailTextField.customize(
            textField: emailTextField,
            view: registrationLabel,
            placeholder: PlaceholderText.email.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        
        firstPassTextField.customizeLayout(topView: emailTextField)
        secondPassTextField.customizeLayout(topView: firstPassTextField)

        registrationButton.customizeCenter(
            button: registrationButton,
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
            parrentView: self,
            topView: registrationButton,
            text: ErrorText.passRegError.rawValue,
            top: LabelsConstants.errorTop.rawValue,
            left: LabelsConstants.errorLeft.rawValue
        )
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        
        signInWithAppleButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signUp, authorizationButtonStyle: .black)
        addSubview(signInWithAppleButton)
        signInWithAppleButton.setupLayout(button: signInWithAppleButton, with: self)
    }
}
