//
//  MainViewCell.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 24.05.2022.
//

import UIKit

class MainViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MainCell"
    var thing: Thing!
    var viewModel: MainCellViewModelProtocol! {
        didSet {
            titleLabel.text = viewModel.title
           
                self.viewModel.getImageData { data in
                    let image = UIImage(data: data)
                    self.imageView.image = image
                }
        }
    }
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        cusomizeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    private func cusomizeUI() {
        imageView.customize(
            imageView: imageView,
            view: self,
            top: 0,
            height: 90
        )
        imageView.backgroundColor = .blue
        
        titleLabel.customize(
            label: titleLabel,
            view: imageView,
            text: "Sometext",
            top: -6,
            left: 8
        )
    }
}
