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
    
    func showAlertWithOneButton(completion: @escaping() -> Void) {
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completion()
        }
        
        addAction(okAction)
    }
    
    func showAlertWithTwoTextField(placeholder: String, completion: @escaping(String, String) -> Void) {
        let changeAction = UIAlertAction(title: "Изменить", style: .default) {[unowned self] _ in
            guard
                let firstText = self.textFields?.first?.text,
                let secondText = self.textFields?.last?.text
            else { return }
            
            completion(firstText, secondText)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        addTextField { textField in
            textField.placeholder = placeholder
        }
        addTextField { textField in
            textField.placeholder = placeholder
        }
        
        addAction(changeAction)
        addAction(cancelAction)
    }
    
    func showAlertWithOneTextField(placeholder: String, completion: @escaping(String) -> Void) {
        let changeAction = UIAlertAction(title: "Изменить", style: .default) { _ in
            guard let text = self.textFields?.first?.text else { return }
            completion(text)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        addTextField { textField in
            textField.placeholder = placeholder
        }
        
        addAction(changeAction)
        addAction(cancelAction)
    }
}

