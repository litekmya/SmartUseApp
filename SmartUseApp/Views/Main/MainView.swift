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
        
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
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
        addSubview(menuButton)
        addSubview(addButton)
        addSubview(titleLabel)
        
        customizeButtons()
        customizeTitlelabel()
    }
    
    private func customizeButtons() {
        menuButton.snp.makeConstraints { make in
            make.leading.equalTo(self).inset(30)
            make.top.equalTo(self).inset(70)
            make.height.width.equalTo(45)
        }
        menuButton.setImage(UIImage(systemName: "star"), for: .normal)
        menuButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        
        addButton.snp.makeConstraints { make in
            make.centerY.equalTo(menuButton)
            make.trailing.equalTo(self).inset(30)
            make.height.width.equalTo(45)
        }
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.setImage(UIImage(systemName: "plus.square"), for: .highlighted)
    }
    
    private func customizeTitlelabel() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(menuButton.snp.bottom).offset(16)
            make.leading.equalTo(self).inset(30)
        }
        titleLabel.text = "Hello, world"
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
    }
}
