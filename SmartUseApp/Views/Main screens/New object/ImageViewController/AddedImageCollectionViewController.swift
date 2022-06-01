//
//  AddedImageCollectionViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 30.05.2022.
//

import UIKit

class AddedImageCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "AddImageCell"
    private var viewModel: AddedImageViewModelProtocol! {
        didSet {
            viewModel.getIcons()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Иконки"
        viewModel = AddedImageViewModel()

        self.collectionView!.register(AddedImageViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.returnNumberOfItemsInSection()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AddedImageViewCell
        let cellViewModel = viewModel.getCellViewModel(at: indexPath.row)
        cell.viewModel = cellViewModel
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension AddedImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    }
}
