//
//  DescriptionView.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 03.07.2022.
//

import UIKit

class DescriptionView: UIView {
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.customizeAppearanceWith(title: "")
                
        return label
    }()
    
    let imageView = UIImageView()
    let informationView = CustomInformationView()
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Статистика", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = 10
        button.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderWidth = 3
        button.backgroundColor = UIColor.darkOlive
        button.setTitleColor(UIColor.newBlue, for: .normal)
        
        return button
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
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(imageView)
        
        addSubview(informationView)
        addSubview(moreButton)
        
        customizeButtons()
        customizeTitle()
        customizeImageView()
        customizeInformationView()
    }
    
    private func customizeTitle() {
        titleLabel.customizeLayoutWithTitle(topView: backButton, parrentView: self)
    }
    
    private func customizeImageView() {
        imageView.customizeWithoutBar(topView: titleLabel, parrentView: self)
    }
    
    private func customizeInformationView() {
        informationView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.leading.trailing.equalTo(self).inset(30)
        }
        
        informationView.staticLeftLabel.text = "Цена"
        informationView.rightStaticLabel.text = "Дата"
    }
    
    private func customizeButtons() {
        backButton.customizeLeftBarButton(parentView: self)
        
        moreButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self).inset(60)
            make.top.equalTo(informationView.snp.bottom).offset(30)
            make.width.equalTo(80)
            make.bottom.equalTo(self).inset(16)
        }
    }
}
