//
//  SettingTableViewCell.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 31.10.2023.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

   //MARK: - Views
    private let countyImageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let countryCodeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let currencyNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textColor = .tabBarUnpressed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let isSelectedImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - Constreints
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [countyImageView, countryCodeLabel, currencyNameLabel, isSelectedImage].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            countyImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countyImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            countyImageView.heightAnchor.constraint(equalToConstant: 30),
            countyImageView.widthAnchor.constraint(equalToConstant: 30),
            countryCodeLabel.centerYAnchor.constraint(equalTo: countyImageView.centerYAnchor),
            countryCodeLabel.leadingAnchor.constraint(equalTo: countyImageView.trailingAnchor, constant: 8),
            currencyNameLabel.centerYAnchor.constraint(equalTo: countyImageView.centerYAnchor),
            currencyNameLabel.leadingAnchor.constraint(equalTo: countryCodeLabel.trailingAnchor, constant: 8),
            isSelectedImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            isSelectedImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            isSelectedImage.heightAnchor.constraint(equalToConstant: 30),
            isSelectedImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Flow func
    func configure(with data: CountryCurrenciesModel) {
        countyImageView.image = UIImage(named: data.currencyCode)
        countryCodeLabel.text = data.currencyCode
        currencyNameLabel.text = data.currencyName
        isSelectedImage.image = UIImage(named: "radio-checked")
    }
}
