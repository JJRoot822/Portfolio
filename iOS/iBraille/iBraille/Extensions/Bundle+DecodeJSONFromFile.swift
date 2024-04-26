//
//  Bundle+DecodeJSONFromFile.swift
//  iBraille
//
//  Created by Joshua Root on 4/21/24.
//

import Foundation

extension Bundle {
    func decode<Value: Decodable>(_ type: Decodable.Protocol, from name: String) -> Value? {
        let decoder = JSONDecoder()
        guard
            let u = self.url(forResource: name, withExtension: "json"),
            let d = try? Data(contentsOf: u),
            let v = try? decoder.decode(Value.self, from: d)
        else {
            return nil
        }
        return v
    }
}
