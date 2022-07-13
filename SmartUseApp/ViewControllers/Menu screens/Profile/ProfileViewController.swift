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
//            goToVC(with: Titles.changeEmail.rawValue)
        } else if indexPath.row == 1 {
            goToVC(with: Titles.changePassword.rawValue)
        } else if indexPath.row == 2 {
            showAlert(message: "Вы пытаетесь выйти из профиля. Продолжить?") {
                self.viewModel.logOff()
            }
        } else {
            showAlert(message: "Вы уверены, что хотите удалить профиль приложения? Его нельзя будет востановить") {
                print("Пользователь пытается удалить профиль")
                self.viewModel.deleteUser {[unowned self] boolian in
                    if boolian {
                        self.viewModel.deleteAllThings()
                        print(1)
                    } else {
                        print(2)
                        self.showAlertWithOneButton {
                            self.viewModel.logOff()
                        }
                    }
                }
            }
        }
    }
    
    private func goToVC(with title: String) {
        let controller = PassRecoveryViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.contentView.titleLabel.text = title
//        controller.contentView.imageView.image = UIImage() Менять картинку при переходе
        
        present(controller, animated: true)
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
    
    private func showAlertWithOneButton(completion: @escaping() -> Void) {
        let alert = AlertController(
            title: "Внимание",
            message: "Для изменения или удаления профиля необходимо авторизоваться. Повторите попытку после повторной авторизации",
            preferredStyle: .alert
        )
        alert.showAlertWithOneButton {
            completion()
        }
        
        present(alert, animated: true)
    }
    
//    private func showAlertWithTextField() {
//        let alert = AlertController(title: <#T##String?#>, message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>)
//    }
}


