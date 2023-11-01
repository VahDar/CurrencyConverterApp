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
    func updateSelectedCurrency(with currency: CountryCurrenciesModel)
    func saveSelectedCurrencyName(_ currencyName: String)
}

class SettingScreenViewModel: SettingScreenViewModelProtocol {
    private var countryManager: CountryCurrenciesManager
    private var userDefaults: UserDefaults
       
    init(countryManager: CountryCurrenciesManager, userDefaults: UserDefaults) {
           self.countryManager = countryManager
           self.userDefaults = userDefaults
    }
       
    func updateSelectedCurrency(with currency: CountryCurrenciesModel) {
            saveSelected(currency: currency.currencyCode)
            saveSelectedCurrencyName(currency.currencyName)
        }
    
    var selectedCurrency: String {
        get {
            return userDefaults.string(forKey: "selectedCurrency") ?? "UAH"
        }
        set {
            userDefaults.set(newValue, forKey: "selectedCurrency")
        }
    }
       
    var listData: [CountryCurrenciesModel] {
        return Array(countryManager.currencyData.values)
    }
       
    func saveSelected(currency: String) {
        selectedCurrency = currency
    }
    
    func saveSelectedCurrencyName(_ currencyName: String) {
        userDefaults.set(currencyName, forKey: "selectedCurrencyName")
    }
    
    func loadSelectedCurrency() {
        selectedCurrency = UserDefaults.standard.string(forKey: "selectedCurrency") ?? "UAH"
    }
       
    func isSelected(_ code: String) -> Bool {
        return selectedCurrency == code
    }
}
