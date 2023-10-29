//
//  AddBidViewController.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 28.10.2023.
//

import UIKit
import SwiftUI

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
    
    private let fromCountryView: SelectedCountry! = {
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
        setupCustomNavBar()
        constreints()
        bindViewModels()
        addCountrySelectionTapGesture()
        checkInput()

    }
    
    //MARK: - Constreins
    private func constreints() {
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        [titleLabel, amountTextField, fromLabel, toLabel, fromCountryView, toCountryView, addButton].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amountTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            amountTextField.heightAnchor.constraint(equalToConstant: 40),
            fromLabel.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 16),
            fromLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fromCountryView.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 9),
            fromCountryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fromCountryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fromCountryView.heightAnchor.constraint(equalToConstant: 76),
            toLabel.topAnchor.constraint(equalTo: fromCountryView.bottomAnchor, constant: 18),
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
    
    //MARK: - Custom NavBar setup
    func setupBackNavBar(title: String, backAction: @escaping () -> Void) {
        let navBar = NavigationBarView(title: title, isBackButtonVisible: true, backAction: backAction)
        let hostingController = UIHostingController(rootView:navBar)
        navigationItem.titleView = hostingController.view
    }
    
    private func setupCustomNavBar() {
        setupBackNavBar(title: "Add Bid") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - Gesture handling
    private func addCountrySelectionTapGesture() {
        let fromTap = UITapGestureRecognizer(target: self, action: #selector(fromCountryTapped))
        fromCountryView.addGestureRecognizer(fromTap)
        
        let toTap = UITapGestureRecognizer(target: self, action: #selector(toCountryTapped))
        toCountryView.addGestureRecognizer(toTap)
    }

    @objc private func fromCountryTapped() {
        viewModel.onSelected?()
        viewModel.target = .from
    }
 
    @objc private func toCountryTapped() {
        viewModel.onSelected?()
        viewModel.target = .to
    }

    //MARK: - ViewModel binding
    private func bindViewModels() {
        if viewModel != nil {
            viewModel.didSelectCountry = { [weak self] selectedCountryName, currencyCode in
                guard let self = self else { return }
                switch viewModel.target {
                case .from:
                    viewModel.fromCode = currencyCode.currencyCode
                    fromCountryView.configure(county: selectedCountryName, currency: currencyCode.currencyName, code: currencyCode.currencyCode)
                case .to:
                    viewModel.toCode = currencyCode.currencyCode
                    toCountryView.configure(county: selectedCountryName, currency: currencyCode.currencyName, code: currencyCode.currencyCode)
                }
            }
        } else {
            print("select country in bindViewModel = nil")
        }
        addButton.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
    }
    
    @objc func handleAddButton() {
            guard let amountStr = self.amountTextField.text,
                  let amount = Double(amountStr) else { return }
                Task {
                try? await self.viewModel.fetchBidData(fromCode: self.viewModel.fromCode, toCode: self.viewModel.toCode, amount: amount)
            }
        viewModel.backAction?()
    }
    
    private func checkInput() {
        amountTextField.addTarget(self, action: #selector(textFieldDidchanged), for: .editingChanged)
        if viewModel != nil {
            self.updateAddButtonState(isValid: !amountTextField.text!.isEmpty, isSelected: self.fromCountryView.isSelected && self.toCountryView.isSelected)
        } else {
            print("Select country in checkInput = nil")
        }
    }
    
    @objc private func textFieldDidchanged(_ textField: UITextField) {
        if viewModel != nil {
            updateAddButtonState(isValid: !textField.text!.isEmpty, isSelected: self.fromCountryView.isSelected && self.toCountryView.isSelected)
        } else {
            print(("Select country in textFieldDidChange = nil"))
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
