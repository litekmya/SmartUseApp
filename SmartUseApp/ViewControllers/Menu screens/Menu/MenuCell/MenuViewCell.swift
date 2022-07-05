//
//  MenuViewCell.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 05.07.2022.
//

import UIKit

class MenuViewCell: UITableViewCell {
    
    static let identifier = "MenuViewCell"
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .blue
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Hello,world"
        
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        customizeUI()
        backgroundColor = .clear
    }
    
    private func customizeUI() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(self).inset(16)
            make.centerY.equalTo(self)
            make.width.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.centerY.equalTo(iconImageView)
        }
    }
}
