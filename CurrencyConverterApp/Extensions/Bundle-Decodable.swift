//
//  Bundle-Decodable.swift
//  CurrencyConverterApp
//
//  Created by Vakhtang on 20.10.2023.
//

import Foundation

extension Bundle {
    
    func decode<T: Decodable>(file: String) -> [String:T] {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in the project!")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not find \(file) in the project!")
        }
        let decoder = JSONDecoder()
        guard let load = try? decoder.decode([String:T].self, from: data) else {
            fatalError("Could not find \(file) in the project!")
        }
        return load
    }
}
