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
    func saveBid(model: BidModel)
    func loadBid() async throws -> [BidModel]
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
    
    @MainActor
    func saveBid(model: BidModel) {
        let realm = try! Realm()
        try! realm.write {
            model.isOpen.toggle()
            realm.add(model, update: .modified)
        }
    }
    
    @MainActor
    func loadBid() async throws -> [BidModel] {
        let realm = try await Realm()
        let item = realm.objects(BidModel.self)
        return Array(item)
    }
}
