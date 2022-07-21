//
//  DailyStatisticsView.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.07.2022.
//

import UIKit

class DailyStatisticsView: UIView {
    
    //MARK: - Views
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
        label.text = "Сколько \n дней \n владеете"
        label.textAlignment = .right
        label.numberOfLines = 0
        
        return label
    }()
    
    let amountPerDayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "5"
        
        return label
    }()
    
    let separationView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.darkOlive
        
        return view
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeUI()
    }
    
    //MARK: - Private methods - Layout
    private func customizeUI() {
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3) // добавить полупрозрачный белый цвет
        layer.cornerRadius = 24
        layer.borderWidth = 3
        layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        
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
