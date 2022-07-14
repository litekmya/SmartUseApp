//
//  RegistrationViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 18.05.2022.
//

import UIKit
import SnapKit
import AuthenticationServices

class AuthorizationViewController: UIViewController {
    
    //MARK: - Private properties
    private let contentView = AuthorizationView()        
    private var viewModel: AuthorizationViewModelProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.errorLabel.isHidden = true
        viewModel = AuthorizationViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        customizeUI()
        addDelegate()
        addTarget()
    }
    
    //MARK: - Private methods
    private func customizeUI() {
        view.addSubview(contentView)
        view.backgroundColor = .white
        contentView.frame = view.frame
    }
    
    //MARK: - Private methods
    private func addDelegate() {
        contentView.emailTextField.delegate = self
        contentView.passwordTextField.delegate = self
    }
    private func addTarget() {
        contentView.logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        contentView.registrationButton.addTarget(self, action: #selector(goToRegistration), for: .touchUpInside)
        contentView.forgotPassButton.addTarget(self, action: #selector(goToPassRecovery), for: .touchUpInside)
        
        contentView.emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        contentView.passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        contentView.passwordTextField.showPassButton.addTarget(self, action: #selector(showPass), for: .touchUpInside)
        
        contentView.signInWithAppleButton.addTarget(self, action: #selector(logInWithApple), for: .touchUpInside)
    }
    
    //MARK: - @objc
    @objc private func logIn() {
        print("Пользователь пытается авторизоваться")
        contentView.activityIndicator.startAnimating()
        
        self.viewModel.logIn(email: contentView.emailTextField.text ?? "", password: contentView.passwordTextField.text ?? "") { [self] error in
            
            if error == nil {
                let welcomeVC = MainViewController()
                self.present(welcomeVC, animated: true)
            } else {
                self.contentView.errorLabel.isHidden = false
                self.contentView.activityIndicator.stopAnimating()
            }
        }
    }
    
    @objc private func goToRegistration() {
        let registrationVC = RegistrationViewController()
        present(registrationVC, animated: true)
    }
    
    @objc private func showPass() {
        contentView.passwordTextField.changeImageForButton()
    }
    
    @objc private func textFieldDidChange() {
        let isEnabled = viewModel.checkFieldsForFullness(
            email: contentView.emailTextField.text ?? "",
            password: contentView.passwordTextField.text ?? ""
        )
        contentView.logInButton.isEnabled = isEnabled
    }
    
    @objc private func goToPassRecovery() {
        let passRecoveryVC = PassRecoveryViewController()
        present(passRecoveryVC, animated: true)
    }
    
    @objc private func logInWithApple() {
        viewModel.logInWithApple(delegate: self, contextController: self)
    }
}

//MARK: - UITextFieldDelegate
extension AuthorizationViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == contentView.emailTextField {
            contentView.emailTextField.resignFirstResponder()
            contentView.passwordTextField.becomeFirstResponder()
        } else {
            logIn()
        }
        
        return true
    }
}

//MARK: - ASAuthorizationControllerDelegate
extension AuthorizationViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("У пользователя не получилось авторизироваться с помощью AppleID")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        viewModel.checkAuthWithApple(auth: authorization)
    }
}

//MARK: - ASAuthorizationControllerPresentationContextProviding
extension AuthorizationViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = view.window else { return ASPresentationAnchor()}
        return window
    }
}
