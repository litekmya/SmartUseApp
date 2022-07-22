//
//  CustomInformationView.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 20.07.2022.
//

import UIKit

class CustomInformationView: UIView {
    
    //MARK: - Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Статистика на текущий день"
        
        return label
    }()
    
    let staticLeftLabel: UILabel = {
        let label = UILabel()
        label.text = "Сколько \n дней \n владеете"
        label.textAlignment = .left
        label.numberOfLines = 0
        // Создать отдельный метод для настройки данного лейбла
        
        return label
    }()
    
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.textAlignment = .left
        
        return label
    }()
    
    let rightStaticLabel: UILabel = {
        let label = UILabel()
        // использовать новый созданный метод
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Во сколько \n обходится \n вещь на  \n текущий день"
        label.textAlignment = .right
        label.numberOfLines = 0
        
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        
        return label
    }()
    
    let separationView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.darkOlive
        view.layer.cornerRadius = 6
        
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
        addSubview(staticLeftLabel)
        addSubview(leftLabel)
        addSubview(separationView)
        addSubview(rightStaticLabel)
        addSubview(rightLabel)
        
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
        staticLeftLabel.customizeStaticStatisticsLabel(
            parentView: self,
            topView: titleLabel,
            left: true
        )
        leftLabel.customizeStatisticsLabel(parentView: self, left: true)
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
        rightStaticLabel.customizeStaticStatisticsLabel(
            parentView: self,
            topView: titleLabel,
            left: false
        )
        
        rightLabel.customizeStatisticsLabel(parentView: self, left: false)
    }
}
