//
//  GlucoseDataList.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/27/24.
//

import SwiftUI
import CoreData

struct GlucoseDataList: View {
    @FetchRequest var measurements: FetchedResults<GTGlucoseMeasurement>

    init(rangeStartDate: Date, rangeEndDate: Date, numberOfRecords: Int, searchTerm: String) {
        let startDate = rangeStartDate as NSDate
        let endDate = rangeEndDate as NSDate
        
        let predicate1 = NSPredicate(format: "%K >= %@ && %K <= %@", "dateMeasured", startDate, "dateMeasured", endDate)
        let predicate2 = NSPredicate(format: "notes contains %@", searchTerm)
        let fetchRequest: NSFetchRequest<GTGlucoseMeasurement> = GTGlucoseMeasurement.fetchRequest()
        fetchRequest.sortDescriptors = [ NSSortDescriptor(keyPath: \GTGlucoseMeasurement.dateMeasured, ascending: true) ]
        fetchRequest.fetchLimit = numberOfRecords
        fetchRequest.predicate = searchTerm.isEmpty ? predicate1 : NSCompoundPredicate(orPredicateWithSubpredicates: [ predicate1, predicate2 ])
        
        self._measurements = FetchRequest<GTGlucoseMeasurement>(fetchRequest: fetchRequest, animation: .default)
    }
    
    var body: some View {
        List {
            ForEach(measurements, id: \.id) { reading in
                GlucoseReadingCell(reading: reading)
            }
        }
    }
}
