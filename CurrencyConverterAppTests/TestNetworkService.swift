//
//  TestNetworkService.swift
//  CurrencyConverterAppTests
//
//  Created by Vakhtang on 10.11.2023.
//

import XCTest
@testable import CurrencyConverterApp

final class TestNetworkService: XCTestCase {

    private var networkService: NetworkingService!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkService = NetworkingService()
        
    }

    override func tearDownWithError() throws {
        networkService = nil
       try super.tearDownWithError()
    }

    func testFetchCurrencyList() async throws {
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/d92cf32d351f4549d332dc96/latest/" + "USD") else {
            XCTFail("URL is invalid")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            XCTAssertNotNil(data)
        } catch {
            XCTAssertThrowsError(error)
        }
    }

//    func testGetAmount() async throws {
//        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/d92cf32d351f4549d332dc96/pair/" + "USD/UAH") else { return }
//        do {
//            let data = try await URLSession.shared.data(from: url)
//            XCTAssertNotNil(data)
//        } catch {
//            throw error
//        }
//    }
//    
//    func test

}
