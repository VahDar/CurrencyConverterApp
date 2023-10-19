//
//  TabBarItem.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 19.10.2023.
//

import UIKit

enum TabBarItem: String {
    case currencyList
    case wallet
    case bids
    case setting
    var imageItems: UIImage? {
        switch self {
        case .currencyList:
            return UIImage(named: "currency-dollar")
        case .wallet:
            return UIImage(named: "wallet")
        case .bids:
            return UIImage(named: "credit-card-alt")
        case .setting:
            return UIImage(named: "settings")
        }
    }
}
