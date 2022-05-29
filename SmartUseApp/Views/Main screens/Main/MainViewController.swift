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
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        title = "Hello"
        customizeUI()
        
    }
    
    //MARK: - Private methods
    private func customizeUI() {
        customizeCollectionView()
        customizeButtons()
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
        
        view.addSubview(collectionView)
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
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCell.reuseIdentifier, for: indexPath) as! MainViewCell
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    }
}
