//
//  ThingDescriptionViewController.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 16.06.2022.
//

import UIKit

class ThingDescriptionViewController: UIViewController {
    
    var viewModel: ThingDescriptionViewModelProtocol!
    
    //MARK: - Private properties
    private let imageView = UIImageView()
    private let costLabel = UILabel()
    private let dateLabel = UILabel()
    private let datePicker = UIDatePicker()
    
    private let deleteButton = UIButton()
    private var editButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        addSubviews()
        customizeUI()
        
        view.backgroundColor = .white
        title = viewModel.name
    }
    
    //MARK: - Private methods
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(costLabel)
        view.addSubview(dateLabel)
        view.addSubview(datePicker)
        view.addSubview(deleteButton)
    }
    
    private func customizeUI() {
        imageView.customize(
            imageView: imageView,
            view: view,
            top: ImageConstants.topAndHeight.rawValue,
            height: ImageConstants.topAndHeight.rawValue
        )
        
        dateLabel.customizeDate(label: dateLabel, view: view, topView: imageView)
        datePicker.customize(datePicker: datePicker, view: view, dateLabel: dateLabel)
        datePicker.locale = Locale.autoupdatingCurrent
        
        deleteButton.customizeCenter(
            button: deleteButton,
            view: view,
            height: ButtonConstants.height.rawValue,
            width: ButtonConstants.wigth.rawValue
        )
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.tintColor = .red
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonAction))
        navigationItem.rightBarButtonItem = editButton
    }
    
    //MARK: - @objc
    @objc private func editButtonAction() {
        
    }
}
