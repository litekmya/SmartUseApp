//
//  MainView.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 04.07.2022.
//

import UIKit

class MainView: UIView {
    
    let menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon4"), for: .normal)
        
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon5"), for: .normal)
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.customizeAppearanceWith(title: "Hello world")
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeUI()
    }
    
    private func customizeUI() {
        backgroundColor = UIColor.lightOlive
        
        addSubview(menuButton)
        addSubview(addButton)
        addSubview(titleLabel)
        
        customizeButtons()
        customizeTitlelabel()
    }
    
    private func customizeButtons() {
        menuButton.customizeLeftBarButton(parentView: self)
        addButton.customizeRightBarButton(parentView: self)
    }
    
    private func customizeTitlelabel() {
        titleLabel.customizeLayoutWithTitle(topView: menuButton, parrentView: self)
    }
}
