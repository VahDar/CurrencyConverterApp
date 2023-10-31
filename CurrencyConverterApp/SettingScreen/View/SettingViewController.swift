//
//  SettingViewController.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 31.10.2023.
//

import UIKit

class SettingViewController: UIViewController {

    //MARK: - Properties
    var viewModel: SettingScreenViewModelProtocol!
    private var countryManager: CountryCurrenciesModel!
    private var savedCode = "UAH"
    
    //MARK: - Views
    private let selectCurrencyLabel: UILabel = {
       let label = UILabel()
        label.text = "Selected Currency"
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectedCode: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Inted-Medium", size: 14)
        label.textColor = .tabBarUnpressed
        label.text =  "Not found"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageCountry: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Constreints
    private func constreints() {
        [selectedCode, imageCountry, selectCurrencyLabel].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            selectCurrencyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 18),
            selectCurrencyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            selectedCode.topAnchor.constraint(equalTo: selectCurrencyLabel.bottomAnchor, constant: 15),
            selectedCode.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageCountry.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            imageCountry.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageCountry.heightAnchor.constraint(equalToConstant: 44),
            imageCountry.widthAnchor.constraint(equalToConstant: 44)
        ])
    }

    //MARK: - SetupUI
    

    
}
