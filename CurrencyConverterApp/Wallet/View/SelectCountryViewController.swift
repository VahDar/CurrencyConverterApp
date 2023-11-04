//
//  SelectCountryViewController.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 24.10.2023.
//

import UIKit
import SwiftUI

protocol SelectViewModelProtocol {
    var backAction: (() -> Void)? { get set }
    var didSelectCountry: ((String, CountryCurrenciesModel) -> Void)? { get set }
}

final class SelectCountryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var viewModel: SelectViewModelProtocol!
    private var countryManager: CountryCurrenciesManager!
    var didSelectCountry: ((String, CountryCurrenciesModel) -> Void)?
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorColor = .tabBarUnpressed
        tableView.register(SelectCountryTableViewCell.self, forCellReuseIdentifier: String(describing: SelectCountryTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpCustomNavBar()
        countryManager = CountryCurrenciesManager()
        tableView.dataSource = self
        tableView.delegate = self
        constraints()
    }
    
    // MARK: - SetUp UI NavBar
    func setupBackNavBar(title: String, backAction: @escaping () -> Void) {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let navBar = NavigationBarView(title: title, isBackButtonVisible: true, backAction: backAction)
        let hostingController = UIHostingController(rootView:navBar)
        navigationItem.titleView = hostingController.view
    }
    
    private func setUpCustomNavBar() {
        setupBackNavBar(title: "Select Country") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    // MARK: - Setup Constreints
    private func constraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    // MARK: - Setup TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryManager.currencyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SelectCountryTableViewCell.self), for: indexPath) as? SelectCountryTableViewCell else {
            fatalError("Unable to dequeue SelectCountryTableViewCell")
        }
        let country = countryManager.currencyData.sorted { $0.key < $1.key }
        let item = country[indexPath.row]
        cell.configure(name: item.value.currencyCode, country: item.key, currency: item.value.currencyName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sortedCountries = countryManager.currencyData.sorted { $0.key < $1.key }
        let item = sortedCountries[indexPath.row]
        viewModel.didSelectCountry?(item.key, item.value)
        viewModel.backAction?()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87.0
    }

}
