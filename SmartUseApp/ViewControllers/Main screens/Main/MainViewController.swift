//
//  MainViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import UIKit



class MainViewController: UIViewController {
    
    var delegate: MainViewControllerDelegate!
    
    //MARK: - Private properties
    private let contentView = MainView()
    
    private var collectionView: UICollectionView!
    private var coreDataIsEmpty = true
    
    private var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.getUserFromFirebase()
            viewModel.getData {
                self.customizeCollectionView()
                self.customizeUI()
                self.coreDataIsEmpty = false
            }
            
            if coreDataIsEmpty {
                self.customizeCollectionView()
                self.customizeUI()
            }
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = MainViewModel()
        collectionView.reloadData()
    }
    
    //MARK: - Private methods
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Hello"
    }
    
    private func customizeUI() {
        customizeContentView()
        customizeButtons()
    }
    
    private func customizeContentView() {
        view.addSubview(contentView)
        view.addSubview(collectionView)
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(200)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom)
            make.width.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    private func customizeButtons() {
        contentView.menuButton.addTarget(self, action: #selector(displayMenu), for: .touchUpInside)
        contentView.addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
    }
    
    private func customizeCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainViewCell.self, forCellWithReuseIdentifier: MainViewCell.reuseIdentifier)
        collectionView.backgroundColor = UIColor.olive
    }
    
    //MARK: - @objc
    @objc private func displayMenu() {
        delegate.toggleMenu()
    }
    
    @objc private func addButtonAction() {
        print("Кнопкa нажата")
        let newObjectVC = NewObjectViewController()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let thingDescriptionVC = ThingDescriptionViewController()
        thingDescriptionVC.viewModel = viewModel.getDescriptionViewModel(index: indexPath.row)
        thingDescriptionVC.modalPresentationStyle = .fullScreen
        
        present(thingDescriptionVC, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
}


