//
//  JSONHelper.swift
//  iBraille
//
//  Created by Joshua Root on 7/10/24.
//

import Foundation

class JSONHelper {
    static func loadData() async -> BrailleDictionary? {
        guard let url = Bundle.main.url(forResource: "Braille", withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let dictionary = try decoder.decode(BrailleDictionary.self,from: data)
        
            return dictionary
        } catch {
            print(error)
            return nil
        }
    }
}
