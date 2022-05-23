//
//  NavigationController + extension.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 22.05.2022.
//

import UIKit

class NavigationController: UINavigationController {
    
    func create(navController: UINavigationController) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
