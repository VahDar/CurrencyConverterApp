//
//  BidsViewController.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 26.10.2023.
//

import UIKit
import SwiftUI
import Combine

protocol BidsViewProtocol: AnyObject {
    func updateTableView()
}

final class BidsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BidsViewProtocol {

    //MARK: - Properties
    var viewModel: BidViewModelProtocol!
    private let searchBar = ReusingSearchBar()
    private var cancellable: AnyCancellable!
    
    // MARK: - Views
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(BidsTableViewCell.self, forCellReuseIdentifier: String(describing: BidsTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupUI()
        useSetupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            constraints()
            fetchData()
        }
    
    private func fetchData() {
        viewModel.loadData()
        tableView.reloadData()
    }
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Constraints
    private func constraints() {
        [tableView].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        navigationController?.navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
    
   private func performSearch(_ searchHandler: @escaping (String) -> ()) {
        self.cancellable = searchBar.$searchText
            .removeDuplicates()
            .sink { searchHandler($0) }
    }
    
   private func setupNavBar(title: String, addAction: @escaping () -> Void, handler: @escaping (String) -> ()) {
        searchBar.title = title
        searchBar.addAction = addAction
        let navBar = contentView(searchBar: searchBar)
        let hostingController = UIHostingController(rootView: navBar)
        navigationItem.titleView = hostingController.view
        performSearch { handler($0) }
    }
    
    private func useSetupNavBar() {
        setupNavBar(title: "Bids") { [weak self] in
            self?.viewModel.addBidAction?()
        } handler: { [weak self] searchText in
            self?.viewModel.searchText = searchText
        }
    }

    //MARK: - Setup TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BidsTableViewCell.self), for: indexPath) as? BidsTableViewCell else {
            fatalError("Unable to dequeue WalletTableViewCell")
    }
        let bidModel = viewModel.data[indexPath.row]
            cell.configure(bidModel)
        if indexPath.row > 0 {
            cell.addSeparator()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selected = viewModel.data[indexPath.row]
            viewModel.save(model: selected)
            tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138.0
    }
}
