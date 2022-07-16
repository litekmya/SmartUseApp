//
//  MenuViewCell.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 05.07.2022.
//

import UIKit

class MenuViewCell: UITableViewCell {
    
    static let identifier = "MenuViewCell"
    var viewModel: MenuCellViewModelProtocol! {
        didSet {
            iconImageView.image = UIImage(named: viewModel.image)
            titleLabel.text = viewModel.title
        }
    }
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Hello,world"
        
        return label
    }()

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
            make.height.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.centerY.equalTo(iconImageView)
        }
    }
}
