//
//  PassRecoveryView.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 03.07.2022.
//

import UIKit

class PassRecoveryView: UIView {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let emailTextField = UITextField()
    
    let resetPassButton = UIButton()
    let errorLabel = UILabel()
    let activityindicator = UIActivityIndicatorView()
    
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
        addSubview(titleLabel)
        addSubview(emailTextField)
        addSubview(resetPassButton)
        addSubview(errorLabel)
        addSubview(activityindicator)
        
        
        imageView.customize(
            imageView: imageView,
            view: self,
            top: ImageConstants.topAndHeight.rawValue,
            height: ImageConstants.topAndHeight.rawValue
        )
        
        titleLabel.customize(
            label: titleLabel,
            parrentView: self,
            topView: imageView,
            text: "Сброс пароля",
            top: LabelsConstants.top.rawValue,
            left: LabelsConstants.left.rawValue
        )
        
        emailTextField.customize(
            textField: emailTextField,
            view: titleLabel,
            placeholder: PlaceholderText.email.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        emailTextField.setupTextInput(emailTextField, contentType: .emailAddress)
        
        resetPassButton.snp.makeConstraints { make in
            make.centerX.equalTo(emailTextField)
            make.height.equalTo(ButtonConstants.height.rawValue)
            make.width.equalTo(ButtonConstants.wigth.rawValue)
        }
        
        resetPassButton.setup(
            button: resetPassButton,
            title: Text.resetPassButtonTitle.rawValue,
            isEnabled: true
        )
        
        resetPassButton.adjust(
            button: resetPassButton,
            view: emailTextField,
            top: -5,
            bottom: nil
        )

        errorLabel.customize(
            label: errorLabel,
            parrentView: self,
            topView: resetPassButton,
            text: ErrorText.emailRecoveryError.rawValue,
            top: 30,
            left: LabelsConstants.errorLeft.rawValue
        )
        errorLabel.isHidden = true
        errorLabel.textColor = .red
        
        activityindicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityindicator.hidesWhenStopped = true
        activityindicator.style = .large
    }
}
