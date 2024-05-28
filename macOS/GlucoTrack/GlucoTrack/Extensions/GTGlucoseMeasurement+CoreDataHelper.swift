//
//  GTGlucoseMeasurement+CoreDataHelper.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/26/24.
//

import CoreData

extension GTGlucoseMeasurement {
    var  measurementUnit: String {
        return unit ?? "Unknown"
    }
}
