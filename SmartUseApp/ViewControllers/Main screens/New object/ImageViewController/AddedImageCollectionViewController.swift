//
//  AddedImageCollectionViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 30.05.2022.
//

import UIKit
import PhotosUI

class AddedImageCollectionViewController: UICollectionViewController {
    
    weak var delegate: NewObjectViewControllerDelegate?
    
    //MARK: - Private properties
    private let reuseIdentifier = "AddImageCell"
    
    private var picker: PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        
        return picker
    }
    
    private var currentImage: UIImage!
    private let imagePlug = "icon8"
    
    private var viewModel: AddedImageViewModelProtocol! {
        didSet {
            viewModel.getIcons()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddedImageViewModel()
        
        customizeUI()
    }
    
    private func customizeUI() {
        title = "Иконки"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView!.register(AddedImageViewCell.self,
                                      forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor.lightOlive
    }
    
    //MARK: - Private methods
    private func presentPHPicker() {
        present(picker, animated: true)
    }
    
    private func sendAPicture() {
        delegate?.update(image: currentImage)
        dismiss(animated: true)
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
        let icon = viewModel.icons[indexPath.row]
        if icon.imageName == imagePlug { 
            presentPHPicker()
        } else {
            self.currentImage = UIImage(named: icon.imageName)
            sendAPicture()
        }
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

//MARK: - PHPickerViewControllerDelegate
extension AddedImageCollectionViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        let itemProviders = results.map(\.itemProvider)
        
        for provider in itemProviders {
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        if var image = image as? UIImage {
                            image = image.resize(scaledTo: CGSize(width: 200, height: 200))
                            guard let imageData = image.jpegData(compressionQuality: 1) else { return }
                            
                            self.currentImage = UIImage(data: imageData)
                            self.sendAPicture()
                        }
                    }
                }
            }
        }
    }
}

