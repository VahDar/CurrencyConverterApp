//
//  SelectCountryTableViewCell.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 24.10.2023.
//

import UIKit

class SelectCountryTableViewCell: UITableViewCell {

    // MARK: Views
    let countryImage: UIImageView  = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = .tabBarUnpressed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    // MARK: - Constreints
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [countryImage, countryLabel, currencyLabel, separator].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            countryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            countryImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            countryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countryImage.heightAnchor.constraint(equalToConstant: 44),
            countryImage.widthAnchor.constraint(equalToConstant: 44),
            countryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            countryLabel.leadingAnchor.constraint(equalTo: countryImage.trailingAnchor, constant: 19),
            currencyLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 5),
            currencyLabel.leadingAnchor.constraint(equalTo: countryImage.trailingAnchor, constant: 19),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Flow funcs
    func configure(name: String, country: String, currency: String) {
        countryImage.image = UIImage(named: name)
        countryLabel.text = country
        currencyLabel.text = currency + " (\(name))"
    }
}
