//
//  WalletModel.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 21.10.2023.
//

import Foundation
import RealmSwift

class WalletModel: Object {
    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var code: String = ""
    @Persisted var amount: Double = 0.0
    @Persisted var usdAmount: Double = 0.0
    
    var formattedAmount: String {
        return String(format: "%.2f", amount)
    }
    
    convenience init(code: String, amount: Double, usdAmount: Double) {
        self.init()
        self.amount = amount
        self.code = code
        self.usdAmount = usdAmount
    }
}


struct RateModel: Codable {
    let conversionRate: Double
    
    enum CodingKeys: String, CodingKey {
        case conversionRate = "conversion_rate"
    }
}
