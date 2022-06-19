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
    private let imageView = UIImageView()
    private let authLabel = UILabel()
    private let registrationLabel = UILabel()
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    
    private let logInButton = UIButton()
    private let forgotPassButton = UIButton()
    private let registrationButton = UIButton()
    private let errorLabel = UILabel()
    private var signInWithAppleButton: ASAuthorizationAppleIDButton!
    
    private var activityIndicator = UIActivityIndicatorView()
    
    private let authTitle = "Авторизация"
    private let registratonLabelText = "Если у вас нет действующего аккаунта, то вы можете"
    private let registrationButtonTitle = "Зарегистрироваться здесь"
    private let errorLabelText = "Введен неверный email и/или пароль"
        
    private var viewModel: AuthorizationViewModelProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        customizeUI()
        addTarget()
        
        errorLabel.isHidden = true
        viewModel = AuthorizationViewModel()
    }
    
    //MARK: - Private methods 'Layout'
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(authLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
        view.addSubview(forgotPassButton)
        view.addSubview(registrationButton)
        view.addSubview(registrationLabel)
        view.addSubview(errorLabel)
        view.addSubview(activityIndicator)
    }
    
    private func customizeUI() {
        imageView.customize(
            imageView: imageView,
            view: self.view,
            top: ImageConstants.topAndHeight.rawValue,
            height: ImageConstants.topAndHeight.rawValue
        )
        
        authLabel.customize(
            label: authLabel,
            view: imageView,
            text: authTitle,
            top: LabelsConstants.top.rawValue,
            left: LabelsConstants.left.rawValue
        )
        
        emailTextField.customize(
            textField: emailTextField,
            view: authLabel,
            placeholder: PlaceholderText.email.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        emailTextField.setupTextInput(emailTextField, contentType: .emailAddress, delegate: self)
        
        passwordTextField.customize(
            textField: passwordTextField,
            view: emailTextField,
            placeholder: PlaceholderText.password.rawValue,
            top: TextFieldConstants.top.rawValue,
            left: TextFieldConstants.left.rawValue
        )
        passwordTextField.setupTextInput(passwordTextField, contentType: .password, delegate: self)
        
        logInButton.setup(
            button: logInButton,
            title: Text.logInButtonTitle.rawValue,
            isEnabled: false
        )
        
        logInButton.customizeCenter(
            button: logInButton,
            view: passwordTextField,
            height: ButtonConstants.height.rawValue,
            width: ButtonConstants.wigth.rawValue
        )
        
        logInButton.adjust(
            button: logInButton,
            view: passwordTextField,
            top: ButtonConstants.centerTop.rawValue,
            bottom: nil
        )
        
        forgotPassButton.setup(
            button: forgotPassButton,
            title: Text.forgotPassButonTitle.rawValue,
            isEnabled: true
        )
        
        forgotPassButton.customizeCenter(
            button: forgotPassButton,
            view: logInButton,
            height: ButtonConstants.height.rawValue,
            width: 250
        )
        
        forgotPassButton.adjust(
            button: forgotPassButton,
            view: logInButton,
            top: ButtonConstants.centerTop.rawValue,
            bottom: nil
        )
        
        registrationLabel.customize(
            label: registrationLabel,
            view: forgotPassButton,
            text: registratonLabelText,
            top: LabelsConstants.top.rawValue,
            left: LabelsConstants.left.rawValue
        )
        
        registrationButton.setup(button: registrationButton, title: registrationButtonTitle, isEnabled: true)
        
        registrationButton.customizeCenter(
            button: registrationButton,
            view: view,
            height: ButtonConstants.height.rawValue,
            width: 250
        )
        
        registrationButton.adjust(button: registrationButton, view: registrationLabel, top: 8, bottom: nil)
        
        errorLabel.customize(
            label: errorLabel,
            view: registrationButton,
            text: errorLabelText,
            top: -15,
            left: LabelsConstants.left.rawValue
        )
        errorLabel.textColor = .red //Скрыть
        
        signInWithAppleButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        view.addSubview(signInWithAppleButton)
        signInWithAppleButton.setupLayout(button: signInWithAppleButton, with: view)
        signInWithAppleButton.addTarget(self, action: #selector(logInWithApple), for: .touchUpInside)
        
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
    }
    
    //MARK: - Private methods
    private func addTarget() {
        logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(goToRegistration), for: .touchUpInside)
        forgotPassButton.addTarget(self, action: #selector(goToPassRecovery), for: .touchUpInside)
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    //MARK: - @objc
    @objc private func logIn() {
        print("Пользователь пытается авторизоваться")
        self.activityIndicator.startAnimating()
        
        self.viewModel.logIn(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "") { error in
            
            if error == nil {
                let welcomeVC = MainViewController()
                self.present(welcomeVC, animated: true)
            } else {
                self.errorLabel.isHidden = false
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    @objc private func goToRegistration() {
        let registrationVC = RegistrationViewController()
        present(registrationVC, animated: true)
    }
    
    @objc private func textFieldDidChange() {
        if (emailTextField.text != "" && passwordTextField.text != "") {
            logInButton.isEnabled = true
        } else {
            logInButton.isEnabled = false
        }
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
        if textField == emailTextField {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
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
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential: let email = credentials.email
        default: break
        }
    }
}

//MARK: - ASAuthorizationControllerPresentationContextProviding
extension AuthorizationViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = view.window else { return ASPresentationAnchor()}
        return window
    }
}
