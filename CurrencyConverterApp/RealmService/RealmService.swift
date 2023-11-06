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
    func loadBid(completion: @escaping ([BidModel]) -> Void)
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
    
    func saveBid(model: BidModel) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            try! realm.write{
                model.isOpen.toggle()
                realm.add(model, update: .modified)
            }
        }
    }
    
    func loadBid(completion: @escaping ([BidModel]) -> Void) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            completion(Array(realm.objects(BidModel.self)))
        }
    }
}
