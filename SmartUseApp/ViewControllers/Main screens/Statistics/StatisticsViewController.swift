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
    private var daysCount: Int!
    
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
    
    deinit {
        print("Deinit")
    }
    
    //MARK: - Layout
    private func customizeView() {
        view.addSubview(scrollView)
    }
    
    private func customizeScrollView() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        scrollView.backgroundColor = UIColor.olive
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
        contentView.dailyView.leftLabel.text = calculateNumberOfDays()
        contentView.dailyView.rightLabel.text = calculateAmountForCurrentDay()
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
        let formatter = CustomDateFormatter()
        
        let previusDate = formatter.convertToDate(string: viewModel.date)
        
        guard let days = Calendar.current.dateComponents([.day], from: previusDate, to: Date()).day else {
            print("Ошибка! Не получилось преобразовать в дату2")
            return ""
        }
        
        daysCount = days
        return String(daysCount)
    }
    
    private func calculateAmountForCurrentDay() -> String {
        if daysCount == 0 {
            daysCount = 1
        }
        let amount = (Float(viewModel.cost) ?? 0) / Float(daysCount)
        print(amount)
        return String(format: "%.2f", amount)
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


