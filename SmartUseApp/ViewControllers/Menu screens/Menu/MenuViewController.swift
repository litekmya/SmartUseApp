//
//  MenuViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 04.07.2022.
//

import UIKit

enum Controllers {
    case profileVC
    case settingsVC
    case about
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
        tableView.backgroundColor = .red
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
        
        let controller = viewModel.goToNextVC(at: indexPath.row)
        let navController = UINavigationController(rootViewController: controller)
        present(navController, animated: true)
    }
}
