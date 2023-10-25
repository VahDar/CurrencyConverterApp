//
//  BidsTableViewCell.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 25.10.2023.
//

import UIKit

class BidsTableViewCell: UITableViewCell {

    // MARK: - Views
    private let fromCountryImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let toCountryImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let currencyNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
    }()
    
    private let caseButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .caseOpen
        button.tintColor = .tintOpen
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let fromAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-SemiBold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-SemiBold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   // MARK: - Constreints
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [fromCountryImage, toCountryImage, caseButton, currencyNameLabel, toAmountLabel, fromAmountLabel].forEach(contentView.addSubview)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
