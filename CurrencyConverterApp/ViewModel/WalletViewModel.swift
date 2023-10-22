//
//  WalletViewModel.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 22.10.2023.
//

import Foundation

protocol WalletViewModelProtocol: SelectViewModelProtocol {
    var walletData: [WalletModel] { get }
    var networkService: NetworkingWalletProtocol! { get set }
    var realmService: RealmServiceProtocol? { get set }
    var currentCode: String { get set }
    var searchText: String { get set}
    var onAddCurrency: (() -> Void)? { get set }
    var onSelect: (() -> Void)? { get set }
    func loadData() async
    func addCurrency(name: String, amount: Double) async throws
    var view: WalletViewProtocol? { get set }
}

final class WalletViewModel: WalletViewModelProtocol {
    var backAction: (() -> Void)?
    var didSelectCountry: ((String, CountryCurrenciesModel) -> Void)?
    var walletData: [WalletModel] = []
    var networkService: NetworkingWalletProtocol!
    var realmService: RealmServiceProtocol?
    var currentCode: String = ""
    var searchText: String = ""
    var onAddCurrency: (() -> Void)?
    var onSelectedCurrency: ((String, CountryCurrenciesModel))?
    var onSelect: (() -> Void)?
    var view: WalletViewProtocol?
    
    init(networkService: NetworkingWalletProtocol,
         realmService: RealmServiceProtocol) {
        self.networkService = networkService
        self.realmService = realmService
    }
    func getAmountUSD(name: String, amount: Double) async throws -> Double {
         try await networkService.getAmount(name: name, amount: amount)
    }
    
    func addCurrency(name: String, amount: Double) async throws {
        Task {
            let amountUSD = try await getAmountUSD(name: name, amount: amount)
            let data = WalletModel(code: name, amount: amount, usdAmount: amountUSD)
            realmService?.saveWallet(model: data)
            await loadData()
            view?.updateTableView()
        }
    }
    
@MainActor
    func loadData() async {
        do {
            walletData = try await realmService?.loadWallet() ?? []
            print("Wallwr DAta - \(walletData)")
        } catch {
            print("Load data error \(error)")
        }
    }
}
