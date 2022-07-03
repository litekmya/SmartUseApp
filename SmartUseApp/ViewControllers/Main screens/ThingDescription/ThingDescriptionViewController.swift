//
//  ThingDescriptionViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 16.06.2022.
//

import UIKit
import Charts
// Добавить scrollView
class ThingDescriptionViewController: UIViewController {
    
    var viewModel: ThingDescriptionViewModelProtocol!
    
    //MARK: - Private properties
    private let scrollView = UIScrollView()
    private let contentView = DescriptionView()
    private var editButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        customizeScrollView()
        customizeContentView()
        customizeButtons()
        getData()
        getDataForCharts()
    }
    
    //MARK: - Private methods
    private func customizeView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = viewModel.name
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
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
    
    private func customizeButtons() {
        editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonAction))
        navigationItem.rightBarButtonItem = editButton
        
        contentView.deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
    }
    
    //MARK: - Private methods
    private func getData() {
        let image = UIImage()
        contentView.imageView.image = image.getImage(from: viewModel.imageData)
                
        let dateFormatter = DateFormatter() // Возможно, нужно убрать в отдельное расширение
        dateFormatter.dateStyle = .short
        guard let date = dateFormatter.date(from: viewModel.date) else { return }
        contentView.datePicker.date = date
        
        contentView.costLabel.text = "Цена: \(viewModel.cost)"
    }
    
    private func getDataForCharts() {
        let entry = BarChartDataEntry(x: 10, y: 1)
        let set = BarChartDataSet(entries: [entry])
        let data = BarChartData(dataSet: set)
        contentView.chart.data = data
    }
    
    //MARK: - @objc
    @objc private func editButtonAction() {
        
    }
    
    @objc private func deleteButtonAction() {
        
    }
}
