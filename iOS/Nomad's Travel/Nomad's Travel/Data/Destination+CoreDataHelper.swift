//
//  Destination+CoreDataHelper.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/19/25.
//

import Foundation
extension Destination {
    var destinationId: UUID {
        set { id = newValue }
        get { id ?? UUID() }
    }
    
    var destinationName: String {
        set { name = newValue }
        get { name ?? "Unnamed" }
    }
    
    var destinationDetails: String {
        set { details = newValue }
        get { details ?? "No Details Provided" }
    }
    
    var destinationLocation: String {
        set { location = newValue }
        get { location ?? "No Location Provided" }
    }
    
    var destinationImageUrl: String {
        set { imageUrl = newValue }
        get { imageUrl ?? "" }
    }
    
    var destinationCreatedAt: Date {
        set { createdAt = newValue }
        get { createdAt ?? .now }
    }
    
    var destinationLastModifiedAt: Date {
        set { lastModifiedAt = newValue }
        get { lastModifiedAt ?? .now }
    }
    
    var destinationTags: [Tag] {
        return tags?.allObjects as? [Tag] ?? []
    }
    
    var formattedCreatedAt: String {
        let formatter = Destination.displayFormatter
        
        return formatter.string(from: destinationCreatedAt)
    }
    
    var fullFormattedCreatedAt: String {
        let formatter = Destination.fullFormatter
        
        return formatter.string(from: destinationCreatedAt)
    }
    
    var formattedLastModifiedAt: String {
        let formatter = Destination.displayFormatter
        
        return formatter.string(from: destinationLastModifiedAt)
    }
    
    var fullFormattedLastModifiedAt: String {
        let formatter = Destination.fullFormatter
        
        return formatter.string(from: destinationLastModifiedAt)
    }
    
    static var fullFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .full
        
        return formatter
    }()
    
    static var displayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter
    }()
}
