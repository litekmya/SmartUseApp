//
//  ThingDescriptionViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 16.06.2022.
//

import UIKit

class ThingDescriptionViewController: UIViewController {
    
    var viewModel: ThingDescriptionViewModelProtocol!
    
    //MARK: - Private properties
    private let scrollView = UIScrollView()
    private let contentView = DescriptionView()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        customizeScrollView()
        customizeContentView()
        addTargetsAndDelegates()
        getData()
    }
    
    //MARK: - Private methods layout
    private func customizeView() {
        view.addSubview(scrollView)
        view.backgroundColor = UIColor.olive
    }
    
    private func customizeScrollView() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        scrollView.addSubview(contentView)
    }
    
    private func customizeContentView() {
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.leading.trailing.equalTo(view)
        }
    }
    
    private func addTargetsAndDelegates() {
        contentView.moreButton.addTarget(self, action: #selector(moreButtonAction), for: .touchUpInside)
        contentView.backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
    }
    
    //MARK: - Private methods
    private func getData() {
        let image = UIImage()
        contentView.titleLabel.text = viewModel.name
        contentView.imageView.image = image.getImage(from: viewModel.imageData)
        contentView.informationView.leftLabel.text = viewModel.cost
        contentView.informationView.rightLabel.text = viewModel.date
    }
    
    //MARK: - @objc
    @objc private func backButtonAction() {
        dismiss(animated: true)
    }
    
    @objc private func moreButtonAction() {
        let statisticsVC = StatisticsViewController()
        statisticsVC.modalPresentationStyle = .fullScreen
        statisticsVC.viewModel = viewModel.getStatisticsViewModel()
        
        present(statisticsVC, animated: true)
    }
}

