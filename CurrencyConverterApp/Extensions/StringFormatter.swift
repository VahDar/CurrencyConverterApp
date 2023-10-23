//
//  StringFormatter.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 23.10.2023.
//

import  UIKit

extension String {
    func createHighlightedAttributedString() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        if self.count >= 3 {
            let lastThreeRange = NSRange(location: self.count - 3, length: 3)
            attributedString.addAttribute(.foregroundColor, value: UIColor.tabBarUnpressed, range: lastThreeRange)
        }
        return attributedString
    }
}
