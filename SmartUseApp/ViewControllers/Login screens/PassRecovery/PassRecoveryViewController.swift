//
//  PassRecoveryViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 24.05.2022.
//

import UIKit

class PassRecoveryViewController: UIViewController {
    
    //MARK: - Private properties
    private let contentView = PassRecoveryView()    
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
        
        contentView.frame = view.frame
        contentView.resetPassButton.addTarget(self, action: #selector(resetPassButtonAction), for: .touchUpInside)
    }

    //MARK: - @objc
    @objc private func resetPassButtonAction() {
        contentView.activityindicator.startAnimating()
        viewModel.recoverPass(with: contentView.emailTextField.text ?? "") { error in
            if error != nil {
                self.contentView.errorLabel.isHidden = false
                self.contentView.activityindicator.stopAnimating()
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
        if textField == contentView.emailTextField {
            resetPassButtonAction()
        }

        return true
    }
}
