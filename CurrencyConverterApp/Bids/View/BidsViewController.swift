//
//  BidsViewController.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 26.10.2023.
//

import UIKit
import SwiftUI
import Combine

class BidsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    
    private func fetchData() {
        Task {
           await viewModel.loadData()
            tableView.reloadData()
        }
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
        if viewModel.searchText.isEmpty {
            return viewModel.data.count
        } else {
            return viewModel.data.filter { ($0.fromCode + $0.toCode).lowercased().contains(viewModel.searchText.lowercased()) }.count
        }
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BidsTableViewCell(style: .default, reuseIdentifier: String(describing: BidsTableViewCell.self))
        let filtredBids = viewModel.data.filter { ($0.fromCode + $0.toCode).lowercased().contains(viewModel.searchText.lowercased())}
        let item = filtredBids[indexPath.row]
        cell.configure(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filteredBids = viewModel.data.filter { ($0.fromCode + $0.toCode).lowercased().contains(viewModel.searchText.lowercased()) }
        let model = filteredBids[indexPath.row]
        viewModel.realmService?.saveBid(model: model)
    }
}
