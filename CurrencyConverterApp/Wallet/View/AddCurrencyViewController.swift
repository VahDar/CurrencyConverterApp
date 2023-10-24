//
//  AddCurrencyViewController.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 24.10.2023.
//

import UIKit
import SwiftUI

class AddCurrencyViewController: UIViewController {

    // MARK: - Properties
    var viewModel: WalletViewModelProtocol!
    private var selectCountryViewModel: SelectViewModelProtocol!
    
    //MARK: - Views
    private let titleLable: UILabel = {
       let label = UILabel()
        label.text = "Owned Value"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectedCountryLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Country Currency"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countryView: SelectedCountry! = {
        let view = SelectedCountry()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.placeholder = "Enter Owned Currency Value"
        textField.textColor = .tabBarPressed
        textField.layer.borderColor = UIColor.tabBarUnpressed.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        view.backgroundColor = .white
        setUpCustomNavBar()
        constraints()
        bindViewModels()
        addCountrySelectionTapGesture()
        checkInput()
    }
    
    //MARK: - Constraints
    private func constraints() {
        navigationItem.hidesBackButton = true
        
        [titleLable, countryView, selectedCountryLabel, amountTextField, addButton].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amountTextField.heightAnchor.constraint(equalToConstant: 40),
            amountTextField.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 18),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectedCountryLabel.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 16),
            selectedCountryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -22),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            countryView.topAnchor.constraint(equalTo: selectedCountryLabel.bottomAnchor, constant: 9),
            countryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            countryView.heightAnchor.constraint(equalToConstant: 87),
           
        ])
    }
    
    // MARK: - Custom Navigation Bar Setup
    func setupBackNavBar(title: String, backAction: @escaping () -> Void) {
        let navBar = NavigationBarView(title: title, isBackButtonVisible: true, backAction: backAction)
        let hostingController = UIHostingController(rootView:navBar)
        navigationItem.titleView = hostingController.view
    }
    
    private func setUpCustomNavBar() {
        setupBackNavBar(title: "Add Owned Currency") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Gesture Handling
    private func addCountrySelectionTapGesture() {
        let addTap = UITapGestureRecognizer(target: self, action: #selector(handleCountrySelection))
        countryView.addGestureRecognizer(addTap)
    }
    
    @objc private func handleCountrySelection() {
        viewModel.onSelect?()
    }
    
    // MARK: - ViewModel Binding
    private func bindViewModels() {
        if viewModel != nil {
            viewModel.didSelectCountry = { [weak self] selectedCountryName, currencyModel  in
                guard let self = self else { return }
                self.viewModel.currentCode = currencyModel.currencyCode
                self.countryView.configure(county: selectedCountryName, currency: currencyModel.currencyName, code: currencyModel.currencyCode)
            }
        } else {
            print("select contry in bindViewModel = nil")
        }
        addButton.addTarget(self, action: #selector(handleAddButtonTap), for: .touchUpInside)
    }
    
    @objc func handleAddButtonTap() {
        guard let amountStr = amountTextField.text,
              let amount = Double(amountStr) else {
            return
        }
        Task {
                try? await self.viewModel.addCurrency(name: self.viewModel.currentCode, amount: amount)
        }
        viewModel.backAction?()
    }
    
    // MARK: - Input Validation
    private func checkInput() {
        amountTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        if let selectCountryViewModel = viewModel {
                updateAddButtonState(isValid: !amountTextField.text!.isEmpty, isSelected: selectCountryViewModel.didSelectCountry != nil)
            } else {
               print("select contry in checkInput = nil")
            }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let selectCountryViewModel = viewModel {
            updateAddButtonState(isValid: !textField.text!.isEmpty, isSelected: selectCountryViewModel.didSelectCountry != nil)
        } else {
            print("select contry in textFieldDidChange = nil")
        }
    }
    
    private func updateAddButtonState(isValid: Bool, isSelected: Bool) {
        if isValid, isSelected {
            self.addButton.backgroundColor = .blue
            self.addButton.isEnabled = true
        } else {
            self.addButton.backgroundColor = .tabBarUnpressed
            self.addButton.isEnabled = false
        }
    }
}

