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

 

}
