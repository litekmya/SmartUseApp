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
        backgroundColor = UIColor.lightOlive
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(emailTextField)
        addSubview(resetPassButton)
        addSubview(errorLabel)
        addSubview(activityindicator)
        
        
        imageView.customize(from: self)
        
        titleLabel.customize(
            parrentView: self,
            topView: imageView,
            newText: "Сброс пароля",
            top: LabelsConstants.top.rawValue,
            left: LabelsConstants.left.rawValue
        )
        
        emailTextField.customize(topView: titleLabel)
        emailTextField.setupTextInput(placeholderText: "Email", contentType: .emailAddress, keyboard: .emailAddress)
        
        resetPassButton.snp.makeConstraints { make in
            make.centerX.equalTo(emailTextField)
            make.height.equalTo(ButtonConstants.height.rawValue)
            make.width.equalTo(ButtonConstants.wigth.rawValue)
        }
        
        resetPassButton.setup(title: Text.resetPassButtonTitle.rawValue, buttonIsEnabled: true)
        
        resetPassButton.adjustOnAxisY(view: emailTextField, top: -5, bottom: nil)

        errorLabel.customize(
            parrentView: self,
            topView: resetPassButton,
            newText: ErrorText.emailRecoveryError.rawValue,
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
