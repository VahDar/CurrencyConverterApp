//
//  WalletViewController.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 21.10.2023.
//

import UIKit
import SwiftUI
import Combine

protocol WalletViewProtocol: AnyObject {
    func updateTableView()
}

class WalletViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WalletViewProtocol {
    
    
    //MARK: - Properties
    var viewModel: WalletViewModelProtocol!
    let searchBar = ReusingSearchBar()
    private var cancellable: AnyCancellable!
    let navBar = NavBar()
    
    // MARK: - Views
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(WalletTableViewCell.self, forCellReuseIdentifier: String(describing: WalletTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Total Balance"
        label.textColor = .tabBarUnpressed
        label.numberOfLines = 0
        label.font = UIFont(name: "Inter-Medium", size: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var balanceLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Inter-Medium", size: 48)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupBalanceLabel()
        setupUI()
        useSetupNavBar()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            constraints()
            fetchData()
        }
    
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.setupBalanceLabel()
        }
    }
    
    private func fetchData() {
        Task {
            await viewModel.loadData()
            setupBalanceLabel()
            tableView.reloadData()
        }
    }
    
    //MARK: - Setup UI
    func setupUI() {
        navigationController?.navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        
    }
    
    func performSearch(_ searchHandler: @escaping (String) -> ()) {
        self.cancellable = searchBar.$searchText
            .removeDuplicates()
            .sink { searchHandler($0) }
    }
    
    func setupNavBar(title: String, addAction: @escaping () -> Void, handler: @escaping (String) -> ()) {
        searchBar.title = title
        searchBar.addAction = addAction
        let navBar = contentView(searchBar: searchBar)
        let hostingController = UIHostingController(rootView: navBar)
        navigationItem.titleView = hostingController.view
        performSearch { handler($0) }
    }
    
    private func useSetupNavBar() {
        setupNavBar(title: "Wallet") { [weak self] in
            self?.viewModel.onAddCurrency?()
        } handler: { [weak self] searchText in
            self?.viewModel.searchText = searchText
        }
    }
    
    
    // MARK: - Constraints
    private func constraints() {
        [tableView, titleLabel, balanceLable].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            balanceLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            balanceLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            tableView.topAnchor.constraint(equalTo: balanceLable.bottomAnchor, constant: 11),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    private func setupBalanceLabel() {
        let balanceWithSymbol = "USD".getSymbolForCurrencyCode() + String(format: "%.2f", viewModel.walletData.reduce(0) { $0 + $1.usdAmount })
        let attributedText = balanceWithSymbol.createHighlightedAttributedString()
        balanceLable.attributedText = attributedText
    }
    
    // MARK: - SetUp TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.walletData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WalletTableViewCell(style: .default, reuseIdentifier: String(describing: WalletTableViewCell.self))
        let item = viewModel.walletData[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121.0
    }

}
