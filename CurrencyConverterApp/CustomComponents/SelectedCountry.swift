//
//  SelectedCountry.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 23.10.2023.
//

import UIKit

class SelectedCountry: UIView {
    // MARK: - Properties
    var isSelected = false
    
    // MARK: - Views
    private var countryFlagView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Empty")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var countryLabel: UILabel = {
       let label = UILabel()
        label.text = "No Country Selected"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var contentView: UIView = {
       let view = UIView()
        view.layer.borderColor = UIColor.tabBarUnpressed.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var currencyLabel: UILabel = {
       let label = UILabel()
        label.text = "--"
        label.textColor = .tabBarUnpressed
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var countryView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 18
        view.layer.borderColor = UIColor.tabBarUnpressed.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Setup UI and constreints
    override init(frame: CGRect) {
           super.init(frame: frame)
           setupSubviews()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupSubviews()
       }
    
    func setupSubviews() {
        addSubview(contentView)
        let labelStackView = UIStackView(arrangedSubviews: [countryLabel, currencyLabel])
        labelStackView.axis = .vertical
        labelStackView.alignment = .leading
        labelStackView.spacing = 0
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelStackView)
        contentView.addSubview(countryFlagView)
        contentView.addSubview(countryView)
        
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            countryFlagView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countryFlagView.heightAnchor.constraint(equalToConstant: 45),
            countryFlagView.widthAnchor.constraint(equalToConstant: 45),
            countryFlagView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            labelStackView.leadingAnchor.constraint(equalTo: countryFlagView.trailingAnchor, constant: 18),
            labelStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(county: String, currency: String, code: String) {
        isSelected = true
        self.countryFlagView.image = UIImage(named: code)
        self.countryLabel.text = county
        self.currencyLabel.text = currency + " (\(code)"
    }
}
