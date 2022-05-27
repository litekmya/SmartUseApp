//
//  AcquaintanceViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 23.05.2022.
//

import UIKit
import SnapKit

class AcquaintanceViewController: UICollectionViewController {
    
    //MARK: - Private Properties
    private var stackView: UIStackView!
    private let previewButton = UIButton()
    private let nextViewButton = UIButton()
    private let pageControl = UIPageControl()
    
    private var viewModel: AcquaintanceViewModelProtocol! {
        didSet {
            viewModel.getPagesData()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AcquaintanceViewModel()
        
        setupStackView()
        customizeCollectionView()
        customizeStackViewLayout()
        customizeButtons()
        customizePageControl()
        addTarget()

    }

    //MARK: - Private methods
    private func customizeCollectionView() {
        collectionView!.register(AcquaintanceViewCell.self, forCellWithReuseIdentifier: AcquaintanceViewCell.reuseIdentifier)
        collectionView.isPagingEnabled = true
        collectionView.addSubview(stackView)
    }
    
    private func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [previewButton, pageControl, nextViewButton])
        }
    
    private func customizeStackViewLayout() {
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(view).inset(35)
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(48)
        }
    }
    
    private func customizeButtons() {
        previewButton.setup(button: previewButton, title: "Начать", isEnabled: true)
        previewButton.adjust(button: previewButton, view: stackView, leading: 16, trailing: nil)
        
        nextViewButton.setup(button: nextViewButton, title: "Вперед", isEnabled: true)
        nextViewButton.adjust(button: nextViewButton, view: stackView, leading: nil, trailing: 16)
    }
    
    private func customizePageControl() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = viewModel.returnNumberOfItemsInSection()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .blue
        
        pageControl.snp.makeConstraints { make in
            make.center.equalTo(stackView)
        }
    }
    
    private func setupDisplayOfPageControl(currentPage: Int) {
        let nextIndex = min(currentPage, viewModel.returnNumberOfItemsInSection() - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    private func addTarget() {
        previewButton.addTarget(self, action: #selector(previewButtonAction), for: .touchUpInside)
        nextViewButton.addTarget(self, action: #selector(nextViewButtonAction), for: .touchUpInside)
    }
    
    private func setupButtonTitle() {
        if pageControl.currentPage < 1 {
            previewButton.setTitle("Начать", for: .normal)
        }
        
        if pageControl.currentPage >= 1 {
            previewButton.setTitle("Назад", for: .normal)
        }
        
        if pageControl.currentPage == viewModel.returnNumberOfItemsInSection() - 1 {
            nextViewButton.setTitle("Начать", for: .normal)
        } else {
            nextViewButton.setTitle("Вперед", for: .normal)
        }
    }
    
    private func goToMainVC(button: UIButton) {
        if button.title(for: .normal) == "Начать" {
            let mainVC = UINavigationController(rootViewController: MainViewController())
            mainVC.modalPresentationStyle = .fullScreen
            present(mainVC, animated: true) {
                // Возможно понадобится
            }
        }
    }
    
    //MARK: - @objc
    @objc private func previewButtonAction() {
        setupDisplayOfPageControl(currentPage: pageControl.currentPage - 1)
        goToMainVC(button: previewButton)
        setupButtonTitle()
    }
    
    @objc private func nextViewButtonAction() {
        setupDisplayOfPageControl(currentPage: pageControl.currentPage + 1)
        goToMainVC(button: nextViewButton)
        setupButtonTitle()
    }
}

// MARK: UICollectionViewDataSource
extension AcquaintanceViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.returnNumberOfItemsInSection()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AcquaintanceViewCell.reuseIdentifier, for: indexPath) as! AcquaintanceViewCell
        
        let cellViewModel = viewModel.getCellViewModel(at: indexPath.row)
        cell.viewModel = cellViewModel
    
        return cell
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let xCoordinate = targetContentOffset.pointee.x
        pageControl.currentPage = Int(xCoordinate / view.frame.width)
        
        setupButtonTitle()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension AcquaintanceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { _ in
            self.collectionViewLayout.invalidateLayout()

            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)

            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } completion: { _ in }
    }
}
