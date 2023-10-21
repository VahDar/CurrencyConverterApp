//
//  ReusingSearchBar.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 21.10.2023.
//

import Foundation
import SwiftUI


class ReusingSearchBar: ObservableObject {
    @Published var searchText: String = ""
    var title = ""
    var addAction: (() -> Void)?
}

struct contentView: View {
    @ObservedObject var searchBar: ReusingSearchBar
    
    var body: some View {
        SearchBarView(searchText: $searchBar.searchText, addAction: searchBar.addAction, tools: [.search, .add], title: searchBar.title)
    }
}
