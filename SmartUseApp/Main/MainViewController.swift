//
//  MainViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Private properties
    private let label = UILabel()
    private var exitButton: UIBarButtonItem! // Времено
    private var addButton: UIBarButtonItem!
    
    private var collectionView: UICollectionView!
    private let reuseIdentifier = "Cell"
    
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
        view.addSubview(label)
        view.addSubview(collectionView)
        
        label.customize(
            label: label,
            view: view,
            text: "Welcome",
            top: 300,
            left: 30
        )
        
        customizeButtons()
        customizeCollectionView()
    }
    
    private func customizeButtons() {
        exitButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logOff))
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction))
        
        navigationItem.leftBarButtonItem = exitButton
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func customizeCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .red
    }
    
    //MARK: - @objc
    @objc private func logOff() {
        FirebaseManager.shared.signOut()
        print("Пользователь вышел")
    }
    
    @objc private func addButtonAction() {
        
    }
}

//MARK: - UICollectonViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
    
    
}
