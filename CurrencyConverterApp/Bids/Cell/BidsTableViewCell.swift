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
        return label
    }()
    
    private let caseButton: UIButton = {
       let button = UIButton()
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
    
    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
   // MARK: - Constreints
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [fromCountryImage, toCountryImage, caseButton, currencyNameLabel, toAmountLabel, fromAmountLabel, arrowImage].forEach(contentView.addSubview)
        
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
            toAmountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),
            arrowImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            arrowImage.centerYAnchor.constraint(equalTo: fromAmountLabel.centerYAnchor),
            arrowImage.heightAnchor.constraint(equalToConstant: 10),
            arrowImage.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Flow func
    
    func configure(_ model: BidModel) {
        arrowImage.image = UIImage(named: "ArrowLong")
        fromCountryImage.image = UIImage(named: model.fromCode)
        toCountryImage.image = UIImage(named: model.toCode)
        fromAmountLabel.attributedText = (model.fromCode.getSymbolForCurrencyCode() + model.stringFromAmount).createHighlightedAttributedString()
        toAmountLabel.attributedText = (model.toCode.getSymbolForCurrencyCode() + model.stringToAmount).createHighlightedAttributedString()
        let currencyCode = model.fromCode + "/" + model.toCode
        let attributedString = NSMutableAttributedString(string: currencyCode)
        let range = (currencyCode as NSString).range(of: "/")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.tabBarUnpressed, range: range)
        currencyNameLabel.attributedText = attributedString
        switch model.isOpen {
        case true: 
            openStatus()
        case false: 
            closedStatus()
        }
    }
    
    private func openStatus() {
        caseButton.backgroundColor = .caseOpen
        caseButton.setTitleColor(UIColor.tintOpen, for: .normal)
        caseButton.setTitle("Open", for: .normal)
    }
    private func closedStatus() {
        caseButton.backgroundColor = .caseClosed
        caseButton.setTitleColor(UIColor.tabBarUnpressed, for: .normal)
        caseButton.setTitle("Closed", for: .normal)
    }
}
