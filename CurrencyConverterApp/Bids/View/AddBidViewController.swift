//
//  AddBidViewController.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 28.10.2023.
//

import UIKit

class AddBidViewController: UIViewController {

    //MARK: - Properties
    var viewModel: BidViewModelProtocol!
    private var selectCountryViewModel: SelectViewModelProtocol!
    
    //MARK: - Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Bid Value (CAD)"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountTextField: UITextField = {
       let textField = UITextField()
        textField.keyboardType = .numberPad
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.placeholder = "Enter Bid Value"
        textField.textColor = .tabBarUnpressed
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let fromLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Country Currency (From)"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Country Currency (To)"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let formCountryView: SelectedCountry! = {
        let view = SelectedCountry()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let toCountryView: SelectedCountry! = {
        let view = SelectedCountry()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Add", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .tabBarUnpressed
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Constreins
    private func constreints() {
        [titleLabel, amountTextField, fromLabel, toLabel, formCountryView, toCountryView].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amountTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            amountTextField.heightAnchor.constraint(equalToConstant: 40),
            fromLabel.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 16),
            fromLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formCountryView.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 9),
            formCountryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formCountryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            formCountryView.heightAnchor.constraint(equalToConstant: 76),
            toLabel.topAnchor.constraint(equalTo: formCountryView.bottomAnchor, constant: 18),
            toLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toCountryView.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 9),
            toCountryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toCountryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            toCountryView.heightAnchor.constraint(equalToConstant: 76),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -22),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

 

}
