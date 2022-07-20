//
//  StatisticsView.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 16.07.2022.
//

import UIKit
import Charts

class StatisticsView: UIView {
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.customizeAppearanceWith(title: "Статистика")
        
        return label
    }()
    
    let segmentedControl: UISegmentedControl = {
        let items = ["Week", "Month", "Year", "Now"]
        let control = UISegmentedControl(items: items)
    
        return control
    }()
    
    let chart: BarChartView = {
        let chart = BarChartView()
        chart.rightAxis.enabled = false
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelFont = .boldSystemFont(ofSize: 16)
        chart.leftAxis.labelFont = .boldSystemFont(ofSize: 16)
        chart.animate(xAxisDuration: 2)
        
        return chart
    }()
    
    let dailyView: DailyStatisticsView = {
        let view = DailyStatisticsView()

        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeUI()
    }
    
    private func customizeUI() {
        backgroundColor = UIColor.lightOlive
        
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(segmentedControl)
        addSubview(chart)
        addSubview(dailyView)
        
        customizeButton()
        customizeTitle()
        customizeSegmentedControl()
        customizeChart()
        customizeDailyView()
    }
    
    private func customizeButton() {
        backButton.customizeLeftBarButton(parentView: self)
    }
    
    private func customizeTitle() {
        titleLabel.customizeLayoutWithTitle(topView: backButton, parrentView: self)
    }
    
    private func customizeSegmentedControl() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalTo(self).inset(30)
        }
    }
    
    private func customizeChart() {
        chart.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(30)
            make.leading.trailing.equalTo(self).inset(30)
            make.height.equalTo(chart.snp.width)
        }
    }
    
    private func customizeDailyView() {
        dailyView.snp.makeConstraints { make in
            make.top.equalTo(chart.snp.bottom).offset(30)
            make.leading.equalTo(self).inset(16)
            make.trailing.equalTo(self).inset(16)
            make.bottom.equalTo(self).inset(30)
        }
        
        dailyView.backgroundColor = .green
    }
}
