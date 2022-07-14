//
//  PassRecoveryViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 24.05.2022.
//

import UIKit

class PassRecoveryViewController: UIViewController {
    
    //MARK: - Private properties
    let contentView = PassRecoveryView()    
    private var viewModel: PassRecoveryViewModelProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        viewModel = PassRecoveryViewModel()
        customizeUI()
    }
    
    //MARK: - Private methods
    private func customizeUI() {
        view.addSubview(contentView)
        view.backgroundColor = .white
        
        customizeContentView()
    }
    
    private func customizeContentView() {
        contentView.frame = view.frame
        contentView.resetPassButton.addTarget(self, action: #selector(resetPassButtonAction), for: .touchUpInside)
        contentView.emailTextField.delegate = self
        contentView.emailTextField.becomeFirstResponder()
    }
    
    private func recoverPass() {
        viewModel.recoverPass(with: contentView.emailTextField.text ?? "") { [unowned self] error in
            if error != nil {
                self.showErrorLabel()
            } else {
                showAlert {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    private func showErrorLabel() {
        contentView.errorLabel.text = AlertError.invalidEmail.rawValue
        contentView.errorLabel.isHidden = false
        contentView.activityindicator.stopAnimating()
    }

    //MARK: - @objc
    @objc private func resetPassButtonAction() {
        contentView.activityindicator.startAnimating()
        recoverPass()
    }
}

//MARK: - UITextFieldDelegate
extension PassRecoveryViewController: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == contentView.emailTextField {
            contentView.emailTextField.resignFirstResponder()
            resetPassButtonAction()
        }

        return true
    }
}

extension PassRecoveryViewController {
    
    private func showAlert(completion: @escaping() -> Void) {
        let alert = AlertController(title: "Ссылка для сброса пароля была отправлена на email",
                                    message: "",
                                    preferredStyle: .alert)
        alert.showAlertWithOneButton {
            completion()
        }
        present(alert, animated: true)
    }
}
