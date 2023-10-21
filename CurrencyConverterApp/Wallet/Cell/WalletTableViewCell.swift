//
//  WalletTableViewCell.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 21.10.2023.
//

import UIKit

class WalletTableViewCell: UITableViewCell {

    //MARK: - Views
    let countryImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let currencyCodeLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "Inter-Medium", size: 24)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 15)
        label.textColor = .tabBarUnpressed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currencyAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Constreits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [currencyCodeLabel, amountLabel, countryImage, currencyAmountLabel].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            currencyAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
            currencyAmountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countryImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            countryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            countryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            countryImage.heightAnchor.constraint(equalToConstant: 60),
            countryImage.widthAnchor.constraint(equalToConstant: 60),
            currencyCodeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 39),
            currencyCodeLabel.leadingAnchor.constraint(equalTo: countryImage.trailingAnchor, constant: 17),
            amountLabel.topAnchor.constraint(equalTo: currencyCodeLabel.bottomAnchor, constant: 2),
            amountLabel.leadingAnchor.constraint(equalTo: countryImage.trailingAnchor, constant: 17)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Flow funcs
    func configure(with data: WalletModel) {
        currencyCodeLabel.text = data.code.uppercased()
        countryImage.image = UIImage(named: data.code)
        currencyAmountLabel.attributedText = (data.code.getSymbolForCurrencyCode() + data.formattedAmount).createHighlightedAttributedString()
        amountLabel.text = "USD".getSymbolForCurrencyCode() + String(format: "%.2f", data.usdAmount)
    }
    
}
