//
//  FilterableTable.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/27/24.
//

import SwiftUI
import CoreData

struct FilterableTable: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest var measurements: FetchedResults<GTGlucoseMeasurement>

    @AppStorage("gt-in-range-lower-bound") var inRangeLowValue: Double = 70.0
    @AppStorage("gt-in-range-upper-bound") var inRangeHighValue: Double = 120.0
    @AppStorage("gt-too-low-upper-bound") var tooLowHighValue: Double = 69.9
    @AppStorage("gt-too-high-lower-bound") var tooHighLowValue: Double = 160.0
    
    
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
        Table(measurements) {
            TableColumn("Glucose Level") { reading in
                Text(reading.formattedMeasurement)
                    .foregroundStyle(getColorBy(value: reading.value))
            }
            TableColumn("Unit", value: \.measurementUnit)
            TableColumn("Date Measured", value: \.formattedMeasurementDate)
            TableColumn("Status") { reading in
                if reading.value >= inRangeLowValue && reading.value <= inRangeHighValue {
                    Text("In Range")
                } else if reading.value > tooHighLowValue && reading.value < inRangeLowValue {
                    Text("Below Range")
                } else if reading.value > inRangeHighValue && reading.value < tooHighLowValue {
                    Text("Above Range")
                } else if reading.value <= tooLowHighValue {
                    Text("Too Low")
                } else {
                    Text("Too High")
                }
            }
            TableColumn("Notes", value: \.userNotes)
        }
    }
    
    private func getColorBy(value: Double) -> Color {
        if value <= tooLowHighValue {
            return .red
        } else if value > tooLowHighValue && value < inRangeLowValue {
            return .yellow
        } else if value >= inRangeLowValue && value <= inRangeHighValue {
            return .green
        } else if value > inRangeHighValue && value < tooHighLowValue {
            return .yellow
        }
        
        return .red
    }
}
