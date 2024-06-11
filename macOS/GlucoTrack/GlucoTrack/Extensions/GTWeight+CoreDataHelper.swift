//
//  GTWeight+CoreDataHelper.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/26/24.
//

import CoreData

extension GTWeight {
    var weightUnit: String {
        return unit ?? "Unknown"
    }
    
    var dateMeasured: Date {
        return dateWeighed ?? Date()
    }
}
