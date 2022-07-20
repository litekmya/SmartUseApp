//
//  DailyStatisticsView.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.07.2022.
//

import UIKit

class DailyStatisticsView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Статистика на текущий день"
        
        return label
    }()
    
    let staticCurrentDayCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Сколько \n дней \n владеете"
        label.textAlignment = .left
        label.numberOfLines = 0
        // Создать отдельный метод для настройки данного лейбла
        
        return label
    }()
    
    
    let currentDayCountLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.textAlignment = .left
        
        return label
    }()
    
    let staticAmountPerDayLabel: UILabel = {
        let label = UILabel()
        // использовать новый созданный метод
        
        return label
    }()
    
    let amountPerDayLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let separationView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.darkOlive
        
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
        backgroundColor = .red // добавить полупрозрачный белый цвет
        addSubview(titleLabel)
        addSubview(staticCurrentDayCountLabel)
        addSubview(currentDayCountLabel)
        addSubview(separationView)
        addSubview(staticAmountPerDayLabel)
        addSubview(amountPerDayLabel)
        
        customizeTitleLabel()
        customizeDaysCountLabels()
        customizeSeparationView()
        customizeAmountLabels()
    }
    
    private func customizeTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    private func customizeDaysCountLabels() {
        staticCurrentDayCountLabel.customizeStaticStatisticsLabel(
            parentView: self,
            topView: titleLabel,
            left: true
        )
        currentDayCountLabel.customizeStatisticsLabel(parentView: self, left: true)
    }
    
    private func customizeSeparationView() {
        separationView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalTo(self)
            make.width.equalTo(4)
            make.bottom.equalTo(self).inset(8)
        }
    }
    
    private func customizeAmountLabels() {
        staticAmountPerDayLabel.customizeStaticStatisticsLabel(
            parentView: self,
            topView: titleLabel,
            left: false
        )
        
        amountPerDayLabel.customizeStatisticsLabel(parentView: self, left: false)
    }
}
