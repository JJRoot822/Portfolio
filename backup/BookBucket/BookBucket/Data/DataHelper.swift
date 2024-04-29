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

class DataHelper {
    func save(context: ModelContext) -> Result<Void, BookBucketDataError> {
        do {
            try context.save()
            
            return .success(())
        } catch {
            return .failure(.saveError)
        }
    }
    
    func insert<T: PersistentModel>(context: ModelContext, model: T) -> Result<Void, BookBucketDataError> {
        context.insert(model)
        
        do {
            try context.save()
            
            return .success(())
        } catch {
            return .failure(.insertError)
        }
    }
    
    func delete<T: PersistentModel>(context: ModelContext, model: T) -> Result<Void, BookBucketDataError> {
        context.delete(model)
        
        do {
            try context.save()
            
            return .success(())
        } catch {
            return .failure(.deleteError)
        }
    }
}
