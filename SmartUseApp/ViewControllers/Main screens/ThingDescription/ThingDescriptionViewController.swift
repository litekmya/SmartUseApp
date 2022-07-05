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
    private var editButton: UIBarButtonItem!
    private var backButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        customizeScrollView()
        customizeContentView()
        customizeButtons()
        getData()
        getDataForCharts()
    }
    
    //MARK: - Private methods layout
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
        }
        
        contentView.chart.delegate = self
    }
    
    private func customizeButtons() {
        editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonAction))
        backButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backButtonAction))
        
        navigationItem.rightBarButtonItem = editButton
        navigationItem.leftBarButtonItem = backButton
        
        contentView.deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
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
        let alert = AlertController(title: "Внимание!", message: "Вы уверены, что хотите удалить данную вещь?", preferredStyle: .alert)
        alert.showAlert {
            print("Вещь была удалена")
        }
        
        present(alert, animated: true)
    }
}

//MARK: - ChartViewDelegate
extension ThingDescriptionViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(Float(entry.y))
    }
}
