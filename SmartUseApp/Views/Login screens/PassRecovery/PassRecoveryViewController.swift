//
//  PassRecoveryViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 24.05.2022.
//

import UIKit

class PassRecoveryViewController: UIViewController {
    
    //MARK: - Private properties
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let emailTextField = UITextField()
    
    private let resetPassButton = UIButton()
    private let errorLabel = UILabel()
    private let activityindicator = UIActivityIndicatorView()
    
    private var viewModel: PassRecoveryViewModelProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        customizeUI()
        
        viewModel = PassRecoveryViewModel()

    }
    
    //MARK: - Private methods
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(resetPassButton)
        view.addSubview(errorLabel)
        view.addSubview(activityindicator)
    }
    
    private func customizeUI() {
        imageView.customize(
            imageView: imageView,
            view: view,
            top: ImageConstants.topAndHeight.rawValue,
            height: ImageConstants.topAndHeight.rawValue
        )
        
        titleLabel.customize(
            label: titleLabel,
            view: imageView,
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
        emailTextField.setupTextInput(emailTextField, contentType: .emailAddress, delegate: self)
        
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
        resetPassButton.addTarget(self, action: #selector(resetPassButtonAction), for: .touchUpInside)

        
        errorLabel.customize(
            label: errorLabel,
            view: resetPassButton,
            text: ErrorText.emailRecoveryError.rawValue,
            top: -30,
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
    
    //MARK: - @objc
    @objc private func resetPassButtonAction() {
        activityindicator.startAnimating()
        viewModel.recoverPass(with: emailTextField.text ?? "") { error in
            if error != nil {
                self.errorLabel.isHidden = false
                self.activityindicator.stopAnimating()
            } else {
                print("Dismiss")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

//MARK: - UITextFieldDelegate
extension PassRecoveryViewController: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            resetPassButtonAction()
        }

        return true
    }
}
