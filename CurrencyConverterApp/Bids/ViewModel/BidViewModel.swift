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
    var fromCode: String { get set }
    var toCode: String { get set }
    var data: [BidModel] { get set }
    var realmService: RealmServiceProtocol! { get set }
    var networkingService: NetworkServiceProtocol! { get set }
    var didSelectCountry: ((String, CountryCurrenciesModel) -> Void)? { get set }
    func fetchBidData(fromCode: String, toCode: String, amount: Double) async throws
}

final class BidViewModel: BidViewModelProtocol {
    var backAction: (() -> Void)?
    var didSelectCountry: ((String, CountryCurrenciesModel) -> Void)?
    var addBidAction: (() -> Void)?
    var onSelected: (() -> Void)?
    var onAction: (() -> Void)?
    var searchText = ""
    var fromCode: String = ""
    var toCode: String = ""
    var data: [BidModel] = []
    var realmService: RealmServiceProtocol!
    var networkingService: NetworkServiceProtocol!
    var target: Target = .from
    
    func fetchBidData(fromCode: String, toCode: String, amount: Double) async throws {
        do {
            let toAmount = try await fetchBidAmount( amount: amount)
            let data = BidModel(fromCode: fromCode, toCode: toCode, fromAmount: amount, toAmount: toAmount)
            realmService.saveBid(model: data)
            Task {
                await loadData()
            }
        } catch {
            print(error)
        }
    }
    
    private func fetchBidAmount( amount: Double) async throws -> Double {
        try await networkingService.getBid(from: fromCode, to: toCode, amount: amount)
    }
    
    func loadData() async {
        do {
            data = try await realmService.loadBid() 
        } catch {
            print("Load data error \(error)")
        }
    }
}

enum Target {
    case from, to
}
