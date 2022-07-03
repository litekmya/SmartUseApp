//
//  AddedImageViewCell.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 30.05.2022.
//

import UIKit

class AddedImageViewCell: UICollectionViewCell {
    
    var viewModel: AddedImageCellViewModelProtocol! {
        didSet {
            imageView.image = UIImage(named: viewModel.imageName)
        }
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = CGFloat(ImageConstants.topAndHeight.rawValue / 2)
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        customizeImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customizeImageView() {
        imageView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.width.height.equalTo(ImageConstants.topAndHeight.rawValue)
        }
    }
}
