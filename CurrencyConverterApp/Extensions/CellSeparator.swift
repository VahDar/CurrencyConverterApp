//
//  CellSeparator.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 29.10.2023.
//

import UIKit

extension UITableViewCell {
    func addSeparator() {
        let separator = UIView()
        separator.backgroundColor = UIColor.lightGray
        addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: topAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    }
}
