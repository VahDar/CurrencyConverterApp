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
    var sevedCode: String { get set }
    func saveSelected(currency: String)
    func loadSelectedCurrency()
    func isSelected(_ code: String) -> Bool
}

class SettingScreenViewModel {
    
}
