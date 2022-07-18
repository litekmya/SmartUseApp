//
//  DescriptionView.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 03.07.2022.
//

import UIKit
import Charts

class DescriptionView: UIView {
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let imageView = UIImageView()
    let costLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "Дата покупки:"
        
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.locale = Locale.autoupdatingCurrent
        picker.datePickerMode = .date
        
        return picker
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
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнее", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        return button
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
        addSubview(imageView)
        addSubview(costLabel)
        addSubview(dateLabel)
        addSubview(datePicker)
        addSubview(chart)
        addSubview(deleteButton)
        
        customizeButtons()
        customizeImageView()
        customizeLabels()
        customizeDatePicker()
        customizeChart()
    }
    
    private func customizeImageView() {
        imageView.customizeWithoutBar(topView: titleLabel, parrentView: self)
    }
    
    private func customizeLabels() {
        titleLabel.customizeLayoutWithTitle(topView: backButton, parrentView: self)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.left.equalTo(self).inset(30)
        }
        
        costLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(30)
            make.centerX.equalTo(self)
        }
    }
    
    private func customizeDatePicker() {
        datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.trailing.equalTo(self).inset(30)
        }
    }
    
    private func customizeChart() {
        chart.snp.makeConstraints { make in
            make.width.equalTo(self)
            make.height.equalTo(chart.snp.width)
            make.top.equalTo(costLabel.snp.bottom).offset(30)
        }
    }
    
    private func customizeButtons() {
        backButton.customizeLeftBarButton(parentView: self)
        
        deleteButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(chart.snp.bottom).offset(30)
            make.bottom.equalTo(self).inset(16)
        }
    }
}
