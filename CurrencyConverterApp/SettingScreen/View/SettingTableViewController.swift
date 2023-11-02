//
//  SettingTableViewController.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 01.11.2023.
//

import UIKit
import Combine
import SwiftUI


class SettingTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Properties
    var viewModel: SettingScreenViewModelProtocol!
    var didSelectCell: ((CountryCurrenciesModel) -> Void)?
    
    //MARK: - Views
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: String(describing: SettingTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Lifecycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setUpCustomNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            constreints()
        }
    
    //MARK: - Constreints
    private func constreints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - Setup UI
    func setupUI() {
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupBackNavBar(title: String, backAction: @escaping () -> Void) {
        let navBar = NavigationBarView(title: title, isBackButtonVisible: true, backAction: backAction)
        let hostingController = UIHostingController(rootView:navBar)
        navigationItem.titleView = hostingController.view
    }
    
    private func setUpCustomNavBar() {
        setupBackNavBar(title: "Selected Currency") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    //MARK: - Setup TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listData.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingTableViewCell(style: .default, reuseIdentifier: String(describing: SettingTableViewCell.self))
        let currency = viewModel.listData[indexPath.row]
        let isSelected = viewModel.isSelected(currency.currencyCode)
        cell.isCellSelected = isSelected
        cell.configure(with: currency)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency = viewModel.listData[indexPath.row]
        didSelectCell?(selectedCurrency)
        viewModel.updateSelectedCurrency(with: selectedCurrency)
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
}
