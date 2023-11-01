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
    private var countryManager: CountryCurrenciesManagerProtocol!
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
    
    private let contentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        constreints()
        tapGesture()
        updateFuncUI()
        view.backgroundColor = .white
    }
    
    //MARK: - Constreints
    private func constreints() {
        view.addSubview(contentView)
        [selectedCode, imageCountry, selectCurrencyLabel].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 90),
            selectCurrencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            selectCurrencyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            selectedCode.topAnchor.constraint(equalTo: selectCurrencyLabel.bottomAnchor, constant: 15),
            selectedCode.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageCountry.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageCountry.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageCountry.heightAnchor.constraint(equalToConstant: 44),
            imageCountry.widthAnchor.constraint(equalToConstant: 44)
        ])
    }

    func tapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(contentViewTapped))
           contentView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func contentViewTapped() {
        let settingTableVC = SettingTableViewController()
        settingTableVC.viewModel = SettingScreenViewModel(countryManager: CountryCurrenciesManager(), userDefaults: UserDefaults.standard)
        settingTableVC.didSelectCell = { selectedCurrency in
            // Use the selected cell data here
            self.updateUI(with: selectedCurrency)
        }
        self.navigationController?.pushViewController(settingTableVC, animated: true)
    }
    
    //MARK: - SetupUI
    
    func updateFuncUI() {
        if !viewModel.selectedCurrency.isEmpty {
            let savedCurrency = viewModel.selectedCurrency
            let savedCurrencyName = countryManager.findCountry(by: savedCurrency) ?? "UAH"
            let countryCurrenciesModel = CountryCurrenciesModel(currencyCode: savedCurrency, currencyName: savedCurrencyName)
            updateUI(with: countryCurrenciesModel)
        }
    }
    
    func updateUI(with currency: CountryCurrenciesModel) {
            selectedCode.text = currency.currencyName
            imageCountry.image = UIImage(named: currency.currencyCode)
        }

    
    
}
