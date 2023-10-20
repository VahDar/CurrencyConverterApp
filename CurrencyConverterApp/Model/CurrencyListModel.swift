//
//  CurrencyListModel.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 20.10.2023.
//

import Foundation

struct CurrencyListModel: Codable {
    
    let conversionRates: [String: Double]

    enum CodingKeys: String, CodingKey {
        case conversionRates = "conversion_rates"
    }
}
