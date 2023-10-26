//
//  BidViewModel.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 26.10.2023.
//

import Foundation

protocol BidViewModelProtocol: SelectViewModelProtocol {
    var addBidAction: (() -> Void)? { get set }
    var onSelected: (() -> Void)? { get set }
    var onAction: (() -> Void)? { get set }
    var target: Target { get set }
    var searchText: String { get }
    var from: String { get set }
    var to: String { get set }
    var data: [BidModel] { get set }
    var realmService: RealmServiceProtocol! { get set }
    var networkingService: NetworkServiceProtocol! { get set }
    var onSelectedCountryAction: ((String, CountryCurrenciesModel) -> Void)? { get set }
    func fetchBidData(fromCode: String, toCode: String, amount: Double) async throws
    func saveData(model: BidModel)
}
