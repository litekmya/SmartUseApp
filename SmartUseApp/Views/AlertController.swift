//
//  AlertController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 03.07.2022.
//

import UIKit

class AlertController: UIAlertController {
    
    func showAlert(completion: @escaping() -> Void) {
        let okAction = UIAlertAction(title: "Ok", style: .destructive) { _ in
            completion()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        addAction(okAction)
        addAction(cancelAction)
    }
}

