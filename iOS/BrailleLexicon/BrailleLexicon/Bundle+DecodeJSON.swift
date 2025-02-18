//
//  Bundle+DecodeJSON.swift
//  iBraille
//
//  Created by Joshua Root on 7/10/24.
//

import Foundation

extension Bundle {
    func loadData(from resourceName: String) -> Data? {
        guard let url = url(forResource: resourceName, withExtension: "json") else {
            return nil
        }
        
        do {
            return try Data(contentsOf: url)
        } catch {
            return nil
        }
    }
    
    func decode<T: Decodable>(to: T.Type, from: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            return try decoder.decode(to, from: from)
        } catch {
            return nil
        }
    }
}
