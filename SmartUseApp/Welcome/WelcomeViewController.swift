//
//  WelcomeViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let label = UILabel()
    private var exitButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        title = "Hello"
        customizeUI()
        
        
    }
    
    private func customizeUI() {
        view.addSubview(label)
        
        label.customize(
            label: label,
            view: view,
            text: "Welcome",
            top: 300,
            left: 30
        )
        
        exitButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logOff))
        navigationItem.leftBarButtonItem = exitButton
    }
    
    @objc private func logOff() {
        FirebaseManager.shared.signOut()
        print("Пользователь вышел")
    }
}
