//
//  DataController.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/18/25.
//

import Cocoa
import CoreData

class DataController {
	let container: NSPersistentContainer!
	
	init(inMemory: Bool = false) {
			container = NSPersistentContainer(name: "CollegeHelper")
		
			if inMemory {
				container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
			}
			
			container.viewContext.automaticallyMergesChangesFromParent = true
			container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
			
			container.loadPersistentStores { _, error in
				if let error {
					fatalError("Fatal error loading store: \(error.localizedDescription)")
				}
			}
		}
	
	func save() {
		let context = container.viewContext

		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				NSApplication.shared.presentError(nserror)
			}
		}
	}
}
