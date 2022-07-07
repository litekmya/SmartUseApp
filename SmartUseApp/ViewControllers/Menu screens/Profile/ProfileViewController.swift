//
//  ProfileViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 06.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var viewModel: ProfileViewModelProtocol! {
        didSet {
            viewModel.getData()
        }
    }
    
    private var tableView: UITableView!
    private let identifier = "Cell"

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
    
    private func customizeTableView() {
        tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        view.addSubview(tableView)
    }
}

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

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            goToVC(with: Titles.changeEmail.rawValue)
        } else if indexPath.row == 1 {
            goToVC(with: Titles.changePassword.rawValue)
        } else {
            print("Удаление аккаунта")
        }
    }
    
    private func goToVC(with title: String) {
        let controller = PassRecoveryViewController()
        controller.contentView.titleLabel.text = title
        
        present(controller, animated: true)
    }
}


