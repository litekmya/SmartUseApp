//
//  MainViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Private properties
    private var exitButton: UIBarButtonItem! // Времено
    private var addButton: UIBarButtonItem!
    
    private var collectionView: UICollectionView!
    
    private var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.getDataFromDatabase {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel = MainViewModel()
        customizeUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    //MARK: - Private methods
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Hello"
        view.backgroundColor = .white
    }
    
    private func customizeUI() {
        customizeCollectionView()
        customizeButtons()
        
        view.addSubview(collectionView)
    }
    
    private func customizeButtons() {
        exitButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logOff))
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction))
        
        navigationItem.leftBarButtonItem = exitButton
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func customizeCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainViewCell.self, forCellWithReuseIdentifier: MainViewCell.reuseIdentifier)
    }
    
    //MARK: - @objc
    @objc private func logOff() {
        FirebaseManager.shared.signOut()
        print("Пользователь вышел")
    }
    
    @objc private func addButtonAction() {
        let newObjectVC = UINavigationController(rootViewController: NewObjectViewController())
        newObjectVC.modalPresentationStyle = .fullScreen
        present(newObjectVC, animated: true)
    }
}

//MARK: - UICollectonViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.returnNumberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCell.reuseIdentifier, for: indexPath) as! MainViewCell
        
        let cellViewModel = viewModel.getCellViewModel(index: indexPath.row)
        cell.viewModel = cellViewModel
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    }
}
