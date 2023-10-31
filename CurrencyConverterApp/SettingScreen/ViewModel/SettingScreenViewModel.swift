//
//  SettingScreenViewModel.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 30.10.2023.
//

import Foundation

protocol SettingScreenViewModelProtocol {
    var onSelectedCurrency: (() -> Void)? { get set }
    var listData: [CountryCurrenciesModel] { get }
    var savedCode: String { get set }
    func saveSelected(currency: String)
    func loadSelectedCurrency()
    func isSelected(_ code: String) -> Bool
}

class SettingScreenViewModel: SettingScreenViewModelProtocol {
    var onSelectedCurrency: (() -> Void)?
    var savedCode = UserDefaults.standard.string(forKey: "selectedCurrency") ?? "UAH"
    var listData: [CountryCurrenciesModel] = []
    
    func saveSelected(currency: String) {
        UserDefaults.standard.set(currency, forKey: "selectedCurrency")
    }
    
    func loadSelectedCurrency() {
        savedCode = UserDefaults.standard.string(forKey: "selectedCurrency") ?? "UAH"
    }
    
    func isSelected(_ code: String) -> Bool {
        savedCode == code
    }
    
}
