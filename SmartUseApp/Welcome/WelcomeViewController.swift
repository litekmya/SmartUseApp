//
//  WelcomeViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        customizeUI()
    }
    
    private func customizeUI() {
        view.addSubview(label)
        
        label.customize(
            label: label,
            view: view,
            text: "Welcome",
            top: LabelsConstants.top.rawValue,
            left: LabelsConstants.left.rawValue
        )
    }

}
