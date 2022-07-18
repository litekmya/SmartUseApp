//
//  ThingDescriptionViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 16.06.2022.
//

import UIKit
import Charts

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
        getDataForCharts()
    }
    
    //MARK: - Private methods layout
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
    }
    
    private func addTargetsAndDelegates() {
        contentView.deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        contentView.backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
        contentView.chart.delegate = self
    }
    
    //MARK: - Private methods
    private func getData() {
        let image = UIImage()
        contentView.imageView.image = image.getImage(from: viewModel.imageData)
                
        let dateFormatter = DateFormatter() // Возможно, нужно убрать в отдельное расширение
        dateFormatter.dateStyle = .short
        guard let date = dateFormatter.date(from: viewModel.date) else { return }
        contentView.datePicker.date = date
        
        contentView.costLabel.text = viewModel.cost
    }
    
    private func getDataForCharts() {
        guard let cost = contentView.costLabel.text else { return }
        var entries: [BarChartDataEntry] = []
        
        for x in 1..<8 {
            guard let costDouble = Double(cost) else { return }
            
            let newSomeCost = costDouble/Double(x)
            print(Double(x))
            print(newSomeCost)
            
            let entry = BarChartDataEntry(x: Double(x) , y: newSomeCost)
            entries.append(entry)
        }
        
        let set = BarChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.joyful()
        
        let data = BarChartData(dataSet: set)
        data.setDrawValues(false)
        contentView.chart.data = data
    }
    
    //MARK: - @objc
    @objc private func editButtonAction() {
        
    }
    
    @objc private func backButtonAction() {
        dismiss(animated: true)
    }
    
    @objc private func deleteButtonAction() {
//        let alert = AlertController(title: "Внимание!", message: "Вы уверены, что хотите удалить данную вещь?", preferredStyle: .alert)
//        alert.showAlert {
//            self.viewModel.deleteThing()
//            print("Вещь была удалена")
//            self.dismiss(animated: true)
//        }
//
//        present(alert, animated: true)
        
        let statisticsVC = StatisticsViewController()
        statisticsVC.modalPresentationStyle = .fullScreen
        
        present(statisticsVC, animated: true)
    }
}

//MARK: - ChartViewDelegate
extension ThingDescriptionViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(Float(entry.y))
    }
}
