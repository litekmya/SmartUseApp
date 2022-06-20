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
    private let contentView = UIView()
    private let imageView = UIImageView()
    private let costLabel = UILabel()
    private let dateLabel = UILabel()
    private let datePicker = UIDatePicker()
    private let chart = BarChartView()
    
    private let deleteButton = UIButton()
    private var editButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        customizeScrollView()
        customizeContentView()
        customizeUI()
        customizeButtons()
        getData()
        getDataForCharts()
    }
    
    //MARK: - Private methods - Layout
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
//            make.width.equalTo(view)
        }
        
        contentView.addSubview(imageView)
        contentView.addSubview(costLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(datePicker)
        contentView.addSubview(chart)
        contentView.addSubview(deleteButton)
        
    }
    
    private func customizeUI() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(30)
            make.width.height.equalTo(100)
            make.centerX.equalTo(contentView)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.left.equalTo(scrollView).inset(300) // исправить
        }
        dateLabel.textColor = .red
        
        datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.trailing.equalTo(contentView)
        }
        datePicker.locale = Locale.autoupdatingCurrent
        datePicker.datePickerMode = .date
        
        costLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(30)
            make.centerX.equalTo(scrollView)
        }
        
        chart.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(chart.snp.width)
            make.top.equalTo(costLabel.snp.bottom).offset(30)
        }
    }
    
    private func customizeButtons() {
        deleteButton.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(chart.snp.bottom).offset(160)
            make.bottom.equalTo(scrollView).inset(16)
        }
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonAction))
        navigationItem.rightBarButtonItem = editButton
    }
    
    //MARK: - Private methods
    private func getData() {
        let image = UIImage()
        imageView.image = image.getImage(from: viewModel.imageData)
                
        let dateFormatter = DateFormatter() // Возможно, нужно убрать в отдельное расширение
        dateFormatter.dateFormat = "dd.MM.yyyy, HH:mm"
        guard let date = dateFormatter.date(from: viewModel.date) else { return }
        datePicker.date = date
        
        costLabel.text = "Цена: \(viewModel.cost)"
    }
    
    private func getDataForCharts() {
        let entry = BarChartDataEntry(x: 10, y: 1)
        let set = BarChartDataSet(entries: [entry])
        let data = BarChartData(dataSet: set)
        chart.data = data
    }
    
    //MARK: - @objc
    @objc private func editButtonAction() {
        
    }
}
