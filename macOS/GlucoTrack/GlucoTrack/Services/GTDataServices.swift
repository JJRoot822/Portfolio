//
//  GTDataServices.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/26/24.
//

import CoreData

enum GTError: LocalizedError {
    case saveError, insertError, deleteError, multipleDeleteError
    
    var errorDescription: String? {
        switch self {
        case .saveError:
            return "Something went wrong when trying to save the changes you made. Please try again later."
        case .insertError:
            return "Something went wrong when trying to create that entry. Please try again later."
        case .deleteError:
            return "Something when wrong when trying to delete that entry. Please try again later."
        case .multipleDeleteError:
            return "Something went wrong when trying to delete the entries you specified. Please try again later."
        }
    }
}

class GTDataService {
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveChanges() throws {
        do {
            try self.context.save()
        } catch {
            throw GTError.saveError
        }
    }
    
    func delete(_ object: NSManagedObject) throws {
        self.context.delete(object)
        
        do {
            try saveChanges()
        } catch {
            throw GTError.deleteError
        }
    }
    
    func delete(_ objects: [NSManagedObject]) throws {
        objects.forEach(context.delete)
        
        do {
            try saveChanges()
        } catch {
            throw GTError.multipleDeleteError
        }
    }
}
