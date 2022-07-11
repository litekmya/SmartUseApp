//
//  MainViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.05.2022.
//

import UIKit



class MainViewController: UIViewController {
    
    //MARK: - Private properties
    private let contentView = MainView()
    
    private var collectionView: UICollectionView!
    private var coreDataIsEmpty = true
    
    var delegate: MainViewControllerDelegate!
    
    private var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.getUserFromFirebase()
            viewModel.getData {
                self.customizeCollectionView()
                self.customizeUI()
                self.coreDataIsEmpty = false
                print("%")
            }
            
            if coreDataIsEmpty {
                self.customizeCollectionView()
                self.customizeUI()
                print("^")
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
        view.backgroundColor = .white
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
        contentView.menuButton.addTarget(self, action: #selector(logOff), for: .touchUpInside)
        contentView.addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
    }
    
    private func customizeCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainViewCell.self, forCellWithReuseIdentifier: MainViewCell.reuseIdentifier)
    }
    
    //MARK: - @objc
    @objc private func logOff() {
//        FirebaseManager.shared.signOut()
//        print("Пользователь вышел")
        
        delegate.toggleMenu()
    }
    
    @objc private func addButtonAction() {
        print("Кнопкa нажата")
        let newObjectVC = NewObjectViewController()
        newObjectVC.modalPresentationStyle = .fullScreen
        
        let navController = UINavigationController(rootViewController: newObjectVC)
        navController.modalPresentationStyle = .fullScreen
        
        present(navController, animated: true)
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
        print("GLGGLGLGLGLGLGLGLLGLGL")
        let thingDescriptionVC = ThingDescriptionViewController()
        thingDescriptionVC.viewModel = viewModel.getDescriptionViewModel(index: indexPath.row)
        
        let navC = UINavigationController(rootViewController: thingDescriptionVC)
        navC.modalPresentationStyle = .fullScreen
        present(navC, animated: true)
//        navigationController?.pushViewController(thingDescriptionVC, animated: true)
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


