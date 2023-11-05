//
//  CurrencyView.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 20.10.2023.
//

import SwiftUI

struct CurrencyView: View {
    
    //MARK: - Properties
    @StateObject var viewModel = CurrencyListViewModel()
    @State private var isUserSearching = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $viewModel.search, tools: [.search], title: "Currency List")
                    .navigationBarHidden(true)
                if viewModel.showWarningMessage {
                    VStack {
                        Spacer()
                        WarningView { Task {
                            viewModel.fetchData()
                        }
                        }
                    }
                }
                List {
                    ForEach(viewModel.searchFilter.sorted(by: { $0.key < $1.key }), id: \.key) { (currencyCode, rate) in
                        CurrencyCellView(imageAndName: currencyCode, currencyName: viewModel.countryCurrenciesManager.findCurrencyName(for: currencyCode) ?? "", amount: rate, selectedCurrency: viewModel.savedName)                        }
                }
                .listStyle(.plain)
                .listRowBackground(Color.clear)
            }
            .onAppear {
                viewModel.fetchData()
            }
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
