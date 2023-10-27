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

    
   

}
