//
//  StatisticsViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 16.07.2022.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = StatisticsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        customizeScrollView()
        customizeContentView()
        addTargetsAndDelegates()
    }
    
    private func customizeView() {
        view.addSubview(scrollView)
    }
    
    private func customizeScrollView() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        scrollView.backgroundColor = UIColor.lightOlive
        scrollView.addSubview(contentView)
    }
    
    private func customizeContentView() {
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.leading.trailing.equalTo(view)
        }
        
        scrollView.contentSize = contentView.frame.size
    }
    
    private func addTargetsAndDelegates() {
        contentView.backButton.addTarget(self,
                                         action: #selector(backButtonAction),
                                         for: .touchUpInside)
        contentView.segmentedControl.addTarget(self,
                                               action: #selector(controlDidChange(_:)),
                                               for: .valueChanged)
        contentView.chart.delegate = self
    }
    
    //MARK: - @objc
    @objc private func backButtonAction() {
        dismiss(animated: true)
    }
    
    @objc private func controlDidChange(_ segmentedControll: UISegmentedControl) {
        switch segmentedControll.selectedSegmentIndex {
        case 0:
            print("0")
        case 1:
            print("1")
        case 2:
            print("2")
        default:
            print("3")
        }
    }
}

extension StatisticsViewController: ChartViewDelegate {
    
}
