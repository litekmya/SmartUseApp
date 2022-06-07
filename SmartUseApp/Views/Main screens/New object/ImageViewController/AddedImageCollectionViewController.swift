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
    private var saveBarButtonItem: UIBarButtonItem!
    private var picker: PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        return picker
    }
    
    private var image: UIImage!
    private var viewModel: AddedImageViewModelProtocol! {
        didSet {
            viewModel.getIcons()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Иконки"
        viewModel = AddedImageViewModel()
        self.collectionView!.register(AddedImageViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationController?.navigationBar.prefersLargeTitles = true
        customizeSaveBarButtonItem()
    }
    
    //MARK: - Private methods
    private func presentPHPicker() {
        print("presentPicker")
        present(picker, animated: true)
    }
    
    private func customizeSaveBarButtonItem() {
        saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBarButtonItemAction))
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    //MARK: - @objc
    @objc private func saveBarButtonItemAction() {
        print("save button")
        print(image.size)
        delegate?.update(image: image)
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
        if icon.imageName == "icons8-женский-торс-50" { // Изменить на константу
            presentPHPicker()
        } else {
            self.image = UIImage(named: icon.imageName)
            saveBarButtonItemAction()
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
                        if let image = image as? UIImage {
                            print(image.size)
                            self.image = image
                            self.saveBarButtonItemAction()
                        }
                    }
                }
            }
        }
    }
}

