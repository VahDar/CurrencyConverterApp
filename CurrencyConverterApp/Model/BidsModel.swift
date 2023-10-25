//
//  BidsModel.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 25.10.2023.
//

import Foundation
import RealmSwift

class BidsModel: Object {
    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var fromCode: String = ""
    @Persisted var toCode: String = ""
    @Persisted var fromAmount: Double = 0.0
    @Persisted var toAmount: Double = 0.0
    @Persisted var isOpen: Bool = false
    
    var stringFormAmount: String {
        return String(format: "%.2f", fromAmount)
    }
    
    var stringToAmount: String {
        return String(format: "%.2f", toAmount)
    }
    
    convenience init(fromCode: String, toCode: String, fromAmount: Double, toAmount: Double) {
        self.init()
        self.fromCode = fromCode
        self.toCode = toCode
        self.fromAmount = fromAmount
        self.toAmount = toAmount
    }
}
