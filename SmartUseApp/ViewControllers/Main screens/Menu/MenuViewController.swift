//
//  MenuViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 04.07.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    private var tableView: UITableView!

    override func viewDidLoad() { // убрать, если не понадобится
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        customizeTableView()
    }
    
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
        5 // изменить
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuViewCell.identifier, for: indexPath) as! MenuViewCell
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
