//
//  SettingScreenViewModel.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 30.10.2023.
//

import Foundation

protocol SettingScreenViewModelProtocol {
    var selectedCurrency: String { get }
    var listData: [CountryCurrenciesModel]  { get }
        
    func saveSelected(currency: String)
    func loadSelectedCurrency()
    func isSelected(_ code: String) -> Bool
}

class SettingScreenViewModel: SettingScreenViewModelProtocol {
    private var countryManager: CountryCurrenciesManager
    private var userDefaults: UserDefaults
       
    init(countryManager: CountryCurrenciesManager, userDefaults: UserDefaults) {
           self.countryManager = countryManager
           self.userDefaults = userDefaults
    }
       
    var selectedCurrency: String {
        get { userDefaults.string(forKey: "selectedCurrency") ?? "UAH" }
        set { userDefaults.set(newValue, forKey: "selectedCurrency") }
    }
       
    var listData: [CountryCurrenciesModel] {
        return Array(countryManager.currencyData.values)
    }
       
    func saveSelected(currency: String) {
        selectedCurrency = currency
    }
       
    func loadSelectedCurrency() {
        selectedCurrency = UserDefaults.standard.string(forKey: "selectedCurrency") ?? "UAH"
    }
       
    func isSelected(_ code: String) -> Bool {
        return selectedCurrency == code
    }
}
