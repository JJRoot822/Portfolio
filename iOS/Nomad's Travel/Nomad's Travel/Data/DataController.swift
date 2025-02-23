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
    
    func createTag(title: String, color: String) throws {
        let tag = Tag(context: container.viewContext)
        tag.tagId = UUID()
        tag.tagTitle = title
        tag.tagColor = color
        tag.tagCreatedAt = .now
        tag.tagLastModifiedAt = .now
        
        try save()
    }
    
    func update(_ tag: Tag, title: String, color: String) throws {
        tag.tagTitle = title
        tag.tagColor = color
        tag.tagLastModifiedAt = .now
    
        try save()
    }
    
    func delete(_ object: NSManagedObject) throws {
        container.viewContext.delete(object)
        
        try save()
    }
    
    func tags(searchTerm: String = "") -> [Tag] {
        let request = Tag.fetchRequest()
        let searchPredicate = NSPredicate(format: "title contains %@", searchTerm)
        let sortDescriptor = SortDescriptor(\Tag.title, order: .forward)
        
        request.sortDescriptors = [
            NSSortDescriptor(sortDescriptor)
        ]
        
        if !searchTerm.isEmpty {
            request.predicate = searchPredicate
        }
        
        let tags = (try? container.viewContext.fetch(request)) ?? []
    
        if request.predicate != nil {
            return tags.filter { !$0.tagTitle.contains("All") }
        }
        
        return tags
    }
}
