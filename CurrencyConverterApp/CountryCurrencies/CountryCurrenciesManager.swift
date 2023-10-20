//
//  CountryCurrenciesManager.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 20.10.2023.
//

import Foundation

protocol CountryCurrenciesManagerProtocol {
    var currencyData: CountryCurrencies { get }
    func findCountry(by currencyCode: String) -> String?
    func findCurrencyName(for currencyCode: String) -> String?
}

final class CountryCurrenciesManager: CountryCurrenciesManagerProtocol {
    
    var currencyData: CountryCurrencies = [:]
    
    init() {
        self.currencyData = Bundle.main.decode(file: "CountryCurrencies.json")
    }
    
    func findCountry(by currencyCode: String) -> String? {
        for (key, value) in currencyData {
            if value.currencyCode == currencyCode {
                return key
            }
        }
        return nil
    }
    
    func findCurrencyName(for currencyCode: String) -> String? {
        if let currencyName = currencyData.first(where: { $0.value.currencyCode == currencyCode }) {
            return currencyName.value.currencyName
        }
        return nil
    }
}
