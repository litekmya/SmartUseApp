//
//  AcquaintanceViewCell.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 23.05.2022.
//

import UIKit

class AcquaintanceViewCell: UICollectionViewCell {
    
    //MARK: - Public properties
    static let reuseIdentifier = "AcquaintanceCell"
    var viewModel: AcquaintanceCellViewModelProtocol! {
        didSet {
            titleLabel.text = viewModel.title
            textLabel.text = viewModel.text
            
            let image = UIImage(systemName: viewModel.image)
            imageView.image = image
        }
    }
    
    //MARK: - Private properties
    private let titleLabel = UILabel()
    private let textLabel = UILabel()
    private let imageView = UIImageView()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customizeView()
        customizeLabels()
        customizeImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private methods
    private func customizeView() {
        addSubview(titleLabel)
        addSubview(textLabel)
        addSubview(imageView)
    }
    
    private func customizeLabels() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).inset(71)
            make.left.right.equalTo(self).inset(16)
        }
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        
        textLabel.customize(label: textLabel, view: titleLabel, text: "viewModel.text", top: -71, left: 16)
    }
    
    private func customizeImageView() {
        imageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(120)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(self.frame.height / 3)
        }
        imageView.layer.cornerRadius = 130 / 2
    }
}
