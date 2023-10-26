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
        
        NSLayoutConstraint.activate([
            fromCountryImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            fromCountryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            fromCountryImage.heightAnchor.constraint(equalToConstant: 34),
            fromCountryImage.widthAnchor.constraint(equalToConstant: 34),
            toCountryImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            toCountryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 43),
            toCountryImage.heightAnchor.constraint(equalToConstant: 34),
            toCountryImage.widthAnchor.constraint(equalToConstant: 34),
            caseButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            caseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            caseButton.heightAnchor.constraint(equalToConstant: 34),
            caseButton.widthAnchor.constraint(equalToConstant: 68),
            currencyNameLabel.topAnchor.constraint(equalTo: fromCountryImage.bottomAnchor, constant: 21),
            currencyNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            fromAmountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),
            fromAmountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            toAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            toAmountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Flow func
    
    func configure(_ model: BidsModel) {
        fromCountryImage.image = UIImage(named: model.fromCode)
        toCountryImage.image = UIImage(named: model.toCode)
        fromAmountLabel.attributedText = (model.fromCode.getSymbolForCurrencyCode() + model.stringFromAmount).createHighlightedAttributedString()
        toAmountLabel.attributedText = (model.toCode.getSymbolForCurrencyCode() + model.stringToAmount).createHighlightedAttributedString()
        let currencyCode = model.fromCode + "/" + model.toCode
        let attributedString = NSMutableAttributedString(string: currencyCode)
        let range = (currencyCode as NSString).range(of: "/")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.tabBarUnpressed, range: range)
        currencyNameLabel.attributedText = attributedString
        setCaseStatus(for: model.isOpen)
    }
    
    private func setCaseStatus( for isOpen: Bool) {
        if isOpen {
            caseButton.backgroundColor = .caseOpen
            caseButton.tintColor = .tintOpen
            caseButton.setTitle("Open", for: .normal)
        } else {
            caseButton.backgroundColor = .caseClosed
            caseButton.tintColor = .tabBarUnpressed
            caseButton.setTitle("Closed", for: .normal)
        }
    }
}
