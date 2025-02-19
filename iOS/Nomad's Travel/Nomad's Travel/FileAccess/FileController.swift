//
//  FileController.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/18/25.
//

import Foundation

class FileController {
    let documentsDirectory: URL
    
    init() {
        self.documentsDirectory = FileManager.documentsDirectory
    }
    
    func write(_ data: Data, to file: String) throws {
        let filePath = documentsDirectory.appendingPathComponent(file)
    
        try data.write(to: filePath)
    }
    
    func read(contentsOf file: String) throws -> Data? {
        let filePath = documentsDirectory.appendingPathComponent(file)
        
        return try? Data(contentsOf: filePath)
    }
}
