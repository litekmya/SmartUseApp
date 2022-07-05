//
//  ContainerViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 04.07.2022.
//

import UIKit
protocol MainViewControllerDelegate {
    
    func toggleMenu()
}

class ContainerViewController: UIViewController, MainViewControllerDelegate {
    
    private var menuViewController: UIViewController!
    var controller: UIViewController!
    private var isMove = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainVC()
    }
    
    func toggleMenu() {
        configureMenuVC()
        isMove.toggle()
        showMenu(shouldMove: isMove)
    }
    
    private func configureMainVC() {
        let viewController = MainViewController()
        viewController.delegate = self
        controller = viewController
        
        view.addSubview(controller.view)
        addChild(controller)
    }
    
    private func configureMenuVC() {
        if menuViewController == nil {
            menuViewController = MenuViewController()
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
            print("Инициализация Меню")
        }
    }
    
    private func showMenu(shouldMove: Bool) {
        if shouldMove {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseInOut) {
                    self.controller.view.frame.origin.x = self.controller.view.frame.width - 140
                } completion: { finished in
                    
                }
            
        } else {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseInOut) {
                    self.controller.view.frame.origin.x = 0
                } completion: { finished in
                    
                }
        }
    }
}
