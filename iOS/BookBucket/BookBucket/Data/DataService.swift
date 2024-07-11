//
//  DataHelper.swift
//  BookBucket
//
//  Created by Joshua Root on 3/25/24.
//

import SwiftData

enum BookBucketDataError: Error {
    case deleteError, insertError, saveError
    
    var localizedDescription: String {
        switch self {
        case .saveError:
            return "Failed to save."
        case .insertError:
            return "Failed to insert the data you entered."
        case .deleteError:
            return "Failed to delete the data you requested."
        }
    }
}

class DataService {
    private var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func save() -> Result<Void, BookBucketDataError> {
        do {
            try context.save()
            
            return .success(())
        } catch {
            return .failure(.saveError)
        }
    }
    
    func insert<T: PersistentModel>(model: T) -> Result<Void, BookBucketDataError> {
        context.insert(model)
        
        do {
            try context.save()
            
            return .success(())
        } catch {
            print("Save error: \(error)")
            return .failure(.insertError)
        }
    }
    
    func delete<T: PersistentModel>(model: T) -> Result<Void, BookBucketDataError> {
        context.delete(model)
        
        do {
            try context.save()
            
            return .success(())
        } catch {
            return .failure(.deleteError)
        }
    }
}
