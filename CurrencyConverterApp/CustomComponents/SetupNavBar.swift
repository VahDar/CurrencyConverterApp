//
//  SetupNavBar.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 21.10.2023.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class NavBar: UIViewController {
    
    let searchBar = ReusingSearchBar()
    private var cancellable: AnyCancellable!
    
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
    
    func setupBackNavBar(title: String, backAction: @escaping () -> Void) {
        let navBar = NavigationBarView(title: title, isBackButtonVisible: true, backAction: backAction)
        let hostingController = UIHostingController(rootView:navBar)
        navigationItem.titleView = hostingController.view
    }
}
