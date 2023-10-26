//
//  BidsViewController.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 26.10.2023.
//

import UIKit

class BidsViewController: UIViewController {

    // MARK: - Views
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(BidsTableViewCell.self, forCellReuseIdentifier: String(describing: BidsTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

   

}
