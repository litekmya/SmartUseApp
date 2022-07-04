//
//  DescriptionView.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 03.07.2022.
//

import UIKit
import Charts

class DescriptionView: UIView {
    
    let imageView = UIImageView()
    let costLabel = UILabel()
    let dateLabel = UILabel()
    let datePicker = UIDatePicker()
    let chart = BarChartView()
    let deleteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeUI()
    }
    
    private func customizeUI() {
        addSubview(imageView)
        addSubview(costLabel)
        addSubview(dateLabel)
        addSubview(datePicker)
        addSubview(chart)
        addSubview(deleteButton)
        
        customizeImageView()
        customizeLabels()
        customizeDatePicker()
        customizeChart()
        customizeDeleteButton()
    }
    
    private func customizeImageView() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self).inset(30)
            make.width.height.equalTo(100)
            make.centerX.equalTo(self)
        }
    }
    
    private func customizeLabels() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.left.equalTo(self).inset(30)
        }
        dateLabel.textColor = .red
        dateLabel.text = "Дата покупки:"
        
        costLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(30)
            make.centerX.equalTo(self)
        }
        costLabel.textColor = .red
    }
    
    private func customizeDatePicker() {
        datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.trailing.equalTo(self).inset(30)
        }
        datePicker.locale = Locale.autoupdatingCurrent
        datePicker.datePickerMode = .date
    }
    
    private func customizeChart() {
        chart.snp.makeConstraints { make in
            make.width.equalTo(self)
            make.height.equalTo(chart.snp.width)
            make.top.equalTo(costLabel.snp.bottom).offset(30)
        }
        
        chart.rightAxis.enabled = false
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelFont = .boldSystemFont(ofSize: 16)
        chart.leftAxis.labelFont = .boldSystemFont(ofSize: 16)
        chart.animate(xAxisDuration: 4)
    }
    
    private func customizeDeleteButton() {
        deleteButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(chart.snp.bottom).offset(30)
            make.bottom.equalTo(self).inset(16)
        }
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    }
}
