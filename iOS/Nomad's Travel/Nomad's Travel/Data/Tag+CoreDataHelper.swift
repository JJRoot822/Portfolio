//
//  Tag+CoreDataHelper.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/19/25.
//

import Foundation

extension Tag {
    var tagId: UUID {
        set { id = newValue }
        get { id ?? UUID() }
    }
    
    var tagTitle: String {
        set { title = newValue }
        get { title ?? "Untitled" }
    }
    
    var tagColor: String {
        set { color = newValue }
        get { color ?? "No Color Provided" }
    }
    
    var tagCreatedAt: Date {
        set { createdAt = newValue }
        get { createdAt ?? .now }
    }
    
    var tagLastModifiedAt: Date {
        set { lastModifiedAt = newValue }
        get { lastModifiedAt ?? .now }
    }
    
    var tagDestinations: [Destination] {
        return destinations?.allObjects as? [Destination] ?? []
    }
    
    var formattedCreatedAt: String {
        let formatter = Tag.displayFormatter
        
        return formatter.string(from: tagCreatedAt)
    }
    
    var fullFormattedCreatedAt: String {
        let formatter = Tag.fullFormatter
        
        return formatter.string(from: tagCreatedAt)
    }
    
    var formattedLastModifiedAt: String {
        let formatter = Tag.displayFormatter
        
        return formatter.string(from: tagLastModifiedAt)
    }
    
    var fullFormattedLastModifiedAt: String {
        let formatter = Tag.fullFormatter
        
        return formatter.string(from: tagLastModifiedAt)
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
