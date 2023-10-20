//
//  CountryCurrenciesModel.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 20.10.2023.
//

import Foundation

struct CountryCurrenciesModel: Codable, Hashable {
    let currencyCode, currencyName: String
    
    enum CodingKeys: String, CodingKey {
        case currencyCode = "Currency Code"
        case currencyName = "Currency Name"
    }
}

typealias CountryCurrencies = [String: CountryCurrenciesModel]
