//
//  MenuViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 04.07.2022.
//

import UIKit

enum Controllers: String {
    
    case profile = "Профиль"
    case settings = "Настройки"
    case about = "О приложении"
}

class MenuViewController: UIViewController {
    
    //MARK: - Private properties
    private var viewModel: MenuViewModelProtocol! {
        didSet {
            viewModel.getMenuDescriptionData()
        }
    }
    private var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MenuViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        customizeTableView()
    }
    
    //MARK: - Private methods
    private func customizeTableView() {
        tableView = UITableView()
        tableView.frame = view.frame
        tableView.register(MenuViewCell.self, forCellReuseIdentifier: MenuViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        tableView.backgroundColor = UIColor.olive
        view.addSubview(tableView)
    }
}

//MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.returnNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuViewCell.identifier, for: indexPath) as! MenuViewCell
        cell.viewModel = viewModel.getCellViewModel(at: indexPath.row)
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = viewModel.getTitleForNextView(at: indexPath.row)
        print(title)
        
        switch Controllers(rawValue: title) {
        case .profile:
            goTo(controller: ProfileViewController(), title: title)
        case .settings:
            goTo(controller: SettingsViewController(), title: title)
        case .about:
            goTo(controller: AboutViewController(), title: title)
        case .none:
            break
        }
    }
    
    private func goTo(controller: UIViewController, title: String) {
        let viewController = controller
        viewController.title = title
        print(viewController)
        
        let navController = UINavigationController(rootViewController: viewController)
        present(navController, animated: true)
    }
}
