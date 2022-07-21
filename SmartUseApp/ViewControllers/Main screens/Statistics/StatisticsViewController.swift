//
//  StatisticsViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 16.07.2022.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController {
    
    var viewModel: StatisticsViewModelProtocol!
    
    //MARK: - Private properties
    private let scrollView = UIScrollView()
    private let contentView = StatisticsView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        customizeScrollView()
        customizeContentView()
        addTargetsAndDelegates()
        
        getDataForChart(count: 8)
        getData()
    }
    
    //MARK: - Layout
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
    
    //MARK: - Private methods
    private func getData() {
        contentView.dailyView.currentDayCountLabel.text = calculateNumberOfDays()
    }
    private func getDataForChart(count: Int) {
        let cost = viewModel.cost
        var entries: [BarChartDataEntry] = []
        
        for axisX in 1..<count {
            let newCost: Double = (Double(cost) ?? 0) / Double(axisX)
            let entry = BarChartDataEntry(x: Double(axisX), y: newCost)
            
            entries.append(entry)
        }

        let set = BarChartDataSet(entries: entries)
        set.drawValuesEnabled = false
        
        let data = BarChartData(dataSet: set)
        contentView.chart.data = data
    }
    
    private func calculateNumberOfDays() -> String {
        let dateFormatter = DateFormatter() // Возможно, нужно убрать в отдельное расширение
        dateFormatter.dateStyle = .short
        
        guard let previusDate = dateFormatter.date(from: viewModel.date) else { return "" }
        guard let days = Calendar.current.dateComponents([.day], from: previusDate, to: Date()).day else { return "" }
        
        return String(days)
    }

    //MARK: - @objc
    @objc private func backButtonAction() {
        dismiss(animated: true)
    }
    
    @objc private func controlDidChange(_ segmentedControll: UISegmentedControl) {
        switch segmentedControll.selectedSegmentIndex {
        case 0:
            getDataForChart(count: 8)
        case 1:
            getDataForChart(count: 32)
        default:
            getDataForChart(count: 366)
        }
    }
}

extension StatisticsViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(Float(entry.y)) // Метод, который выполняется, когда пользователь нажимает на какой нить объект из графика Charts
    }
}


