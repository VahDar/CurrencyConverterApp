//
//  CurrencyListViewModel.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 20.10.2023.
//

import SwiftUI


class CurrencyListViewModel: ObservableObject {
    
    var searchFilter: [String : Double] {
        guard !search.isEmpty else { return conversion }
        
        return conversion.filter { item in
            item.key.localizedCaseInsensitiveContains(search.lowercased())
        }
    }
    
    var countryCurrenciesManager: CountryCurrenciesManagerProtocol = CountryCurrenciesManager()
    @Published var currencyNames: [String: String] = [:]
    var networkService: NetworkingService!
    var savedName: String = ""
    @Published var conversion: [String : Double] = [:]
    @Published var showWarningMessage: Bool = false
    @Published var search: String = ""
    
    init() {
        self.networkService = NetworkingService()
    }
    
    func fetchRates() async throws {
        
        let data = try await networkService.fetchCurrencyList(for: savedName)
        
        DispatchQueue.main.async {
            let conversionRates = data.conversionRates
            self.conversion = conversionRates
            self.conversion.removeValue(forKey: self.savedName)
            self.showWarningMessage = false
        }
    }
    
    func fetchData() {
        let load = UserDefaults.standard.string(forKey: "selectedCurrency") ?? "USD"
        if savedName != load {
            savedName = load
            Task {
                do {
                    try await fetchRates()
                } catch {
                    DispatchQueue.main.async {
                        self.showWarningMessage = true
                    }
                }
            }
        }
    }
}
