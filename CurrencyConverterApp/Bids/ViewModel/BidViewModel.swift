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
    var searchText: String { get set }
    var fromCode: String { get set }
    var toCode: String { get set }
    var data: [BidModel] { get set }
    var realmService: RealmServiceProtocol? { get set }
    var networkingService: NetworkingBidsProtocol! { get set }
    var didSelectCountry: ((String, CountryCurrenciesModel) -> Void)? { get set }
    func fetchBidData(fromCode: String, toCode: String, amount: Double) async throws
    func loadData() async
    var view: BidsViewProtocol? { get set }
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
    var realmService: RealmServiceProtocol?
    var networkingService: NetworkingBidsProtocol!
    var target: Target = .from
    var view: BidsViewProtocol?
    
    init(networkingService: NetworkingBidsProtocol, realmService: RealmServiceProtocol) {
        self.networkingService = networkingService
        self.realmService = realmService
    }
    
    func fetchBidData(fromCode: String, toCode: String, amount: Double) async throws {
        Task {
            let toAmount = try await getBidAmount(amount: amount)
            let data = BidModel(fromCode: fromCode, toCode: toCode, fromAmount: amount, toAmount: toAmount)
            realmService?.saveBid(model: data)
            await loadData()
            view?.updateTableView()
        }
    }
    
    private func getBidAmount(amount: Double) async throws -> Double {
        do {
             let bidAmount = try await networkingService.getBid(from: fromCode, to: toCode, amount: amount)
             return bidAmount
         } catch {
             print("Error in getBidAmount: \(error)")
             throw error
         }
     }
   
    
@MainActor
    func loadData() async {
        do {
            data = try await realmService?.loadBid() ?? []
        } catch {
            print("Load data error \(error)")
        }
    }
}

enum Target {
    case from, to
}

