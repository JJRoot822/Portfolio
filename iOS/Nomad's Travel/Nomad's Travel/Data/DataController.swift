//
//  DataController.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/18/25.
//

import CoreData

class DataController {
    let inMemory: Bool
    
    init(inMemory: Bool = false) {
        self.inMemory = inMemory
    }
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Main")
        
        if inMemory {
                    container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
                }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func save() throws {
        if container.viewContext.hasChanges {
            try container.viewContext.save()
        }
    }
}
