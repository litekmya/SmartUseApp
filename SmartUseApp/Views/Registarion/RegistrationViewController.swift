//
//  RegistrationViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let registrationLabel = UILabel()
    
    private let loginTextField = UITextField()
    private let firstPassTextField = UITextField()
    private let secondPassTextField = UITextField()
    
    private let registrationButton = UIButton()
    private let signInWithAppleButton = UIButton()
    
    private let errorLabel = UILabel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        customizeUI()
    }
    
    private func customizeUI() {
        view.addSubview(imageView)
        view.addSubview(registrationLabel)
        view.addSubview(loginTextField)
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
        
        loginTextField.customize(
            textField: loginTextField,
            view: registrationLabel,
            placeholder: Text.login.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        
        firstPassTextField.customize(
            textField: firstPassTextField,
            view: loginTextField,
            placeholder: Text.password.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        
        secondPassTextField.customize(
            textField: secondPassTextField,
            view: firstPassTextField,
            placeholder: Text.password.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        
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

}
