//
//  RealmService.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 23.10.2023.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    func saveWallet(model: WalletModel)
    func loadWallet() async throws -> [WalletModel]
}

final class RealmService: RealmServiceProtocol {
    @MainActor
    func saveWallet(model: WalletModel) {
        let realm = try! Realm()
        try! realm.write {
        realm.add(model, update: .modified)
        }
    }
    
    @MainActor
    func loadWallet() async throws -> [WalletModel] {
        let realm = try await Realm()
        let item = realm.objects(WalletModel.self)
        return Array(item)
    }
}
