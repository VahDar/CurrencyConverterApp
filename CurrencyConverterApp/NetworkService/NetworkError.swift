//
//  NetworkError.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 20.10.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidData
    case jsonParsingFailed
    case networkServiceUnavailable
    case networkError(Error)
}
