//
//  FileManager+DocumentsDirectory.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/18/25.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let manager = FileManager.default
        
        return manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
