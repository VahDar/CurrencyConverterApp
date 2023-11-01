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
    
    private let contentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Constreints
    private func constreints() {
        view.addSubview(contentView)
        [selectedCode, imageCountry, selectCurrencyLabel].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 135),
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
        self.navigationController?.pushViewController(settingTableVC, animated: true)
    }
    
    //MARK: - SetupUI
    

    
}
