//
//  ProfileViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 06.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Private properties
    private var viewModel: ProfileViewModelProtocol! {
        didSet {
            viewModel.getData()
        }
    }
    
    private var tableView: UITableView!
    private let identifier = "Cell"
    private let logOffMessage = "Для изменения или удаления профиля необходимо авторизоваться. Повторите попытку после повторной авторизации"

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ProfileVC")
        title = "Профиль"
        viewModel = ProfileViewModel()
        customizeTableView()
    }
    
    deinit {
        print("ProfileVC deinit")
    }
    
    //MARK: - Private methods
    private func customizeTableView() {
        tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        view.addSubview(tableView)
    }
}

//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.returnNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let profileChange = viewModel.profileChanges[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = profileChange.title
        
        cell.contentConfiguration = content
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            showAlertWithTextField(placeholder: "Email") { email in
                self.viewModel.change(email: email) { error in
                    self.check(error: error) {
                        
                    }
                }
            }
        } else if indexPath.row == 1 {
            showAlertWithTextField(placeholder: "Password") {[unowned self] password in
                self.viewModel.change(password: password) { error in
                    print(error)
                }
            }
        } else if indexPath.row == 2 {
            showAlert(message: "Вы пытаетесь выйти из профиля. Продолжить?") {
                self.viewModel.logOff()
            }
        } else {
            showAlert(message: "Вы уверены, что хотите удалить профиль приложения? Его нельзя будет востановить") {[unowned self] in
                self.viewModel.deleteUser { boolian in
                    if boolian {
                        self.viewModel.deleteAllThings()
                    } else {
                        self.repeatAuthoriation()
                    }
                }
            }
        }
    }
    
    private func repeatAuthoriation() {
        showAlertWithOneButton(message: logOffMessage) { [unowned self] in
            self.viewModel.logOff()
        }
    }
    
    private func check(error: Error?, completion: () -> Void) {
        if error != nil {
            showAlertWithOneButton(message: logOffMessage) { [unowned self] in
                self.viewModel.logOff()
            }
        } else {
            completion()
        }
    }
}

//MARK: - Alert
extension ProfileViewController {
    
    private func showAlert(message: String, completion: @escaping() -> Void) {
        let alert = AlertController(title: "Внимание", message: message, preferredStyle: .alert)
        alert.showAlert {
            completion()
        }
        
        present(alert, animated: true)
    }
    
    private func showAlertWithOneButton(message: String, completion: @escaping() -> Void) {
        let alert = AlertController(
            title: "Внимание",
            message: message,
            preferredStyle: .alert
        )
        alert.showAlertWithOneButton {
            completion()
        }
        
        present(alert, animated: true)
    }
    
    private func showAlertWithTextField(placeholder: String, completion: @escaping( String) -> Void) {
        let alert = AlertController(title: "Введите новые данные", message: "", preferredStyle: .alert)
        
        alert.showAlertWithTextField(placeholder: placeholder) { text, secondText in
            if !self.viewModel.checkForIdentity(firstPass: text, secondPass: secondText) {
                self.showAlertWithOneButton(message: AlertError.passwordMismatch.rawValue) {}
            } else if !self.viewModel.check(password: text) {
                self.showAlertWithOneButton(message: AlertError.shortPassword.rawValue) {}
            } else {
                completion(text)
            }
        }
        
        present(alert, animated: true)
    }
}


