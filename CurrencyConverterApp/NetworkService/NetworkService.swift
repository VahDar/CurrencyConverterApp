//
//  NetworkService.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 20.10.2023.
//

import Foundation

typealias NetworkServiceProtocol = NetworkingCurrencyListProtocol & NetworkingWalletProtocol & NetworkingBidsProtocol

protocol NetworkingCurrencyListProtocol {
    func fetchCurrencyList(for name: String) async throws -> CurrencyListModel
}

protocol NetworkingWalletProtocol {
   func  getAmount(name: String, amount: Double) async throws -> Double
}

protocol NetworkingBidsProtocol {
    func getBid(from: String, to: String, amount: Double) async throws -> Double
}

final class NetworkingService: NetworkServiceProtocol  {
    
    func fetchCurrencyList(for name: String) async throws -> CurrencyListModel {
        guard let url = URL(string: Api.list.rawValue + name) else { throw NetworkError.invalidURL }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(CurrencyListModel.self, from: data)
            return response
        } catch {
            throw error
        }
    }
    
    func getAmount(name: String, amount: Double) async throws -> Double {
        guard let url = URL(string: Api.pair.rawValue + "\(name)/USD") else
        { throw NetworkError.invalidURL }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(RateModel.self, from: data)
            let amount = response.conversionRate * amount
            return amount
        } catch {
            throw NetworkError.networkError(error)
        }
    }
    
    func getBid(from: String, to: String, amount: Double) async throws -> Double {
        guard let url = URL(string: Api.pair.rawValue + from + "/" + to) else { throw NetworkError.invalidURL }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(RateModel.self, from: data)
            let amount = response.conversionRate * amount
            return amount
        } catch {
            throw NetworkError.networkError(error)
        }
    }
    
}
