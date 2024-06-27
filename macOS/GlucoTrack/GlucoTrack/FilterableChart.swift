//
//  FilterableChart.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/26/24.
//

import SwiftUI
import CoreData
import Charts

struct FilterableChart: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest var measurements: FetchedResults<GTGlucoseMeasurement>

    @AppStorage("gt-in-range-lower-bound") var inRangeLowValue: Double = 70.0
    @AppStorage("gt-in-range-upper-bound") var inRangeHighValue: Double = 120.0
    @AppStorage("gt-too-low-upper-bound") var tooLowHighValue: Double = 69.9
    @AppStorage("gt-too-high-lower-bound") var tooHighLowValue: Double = 160.0
    
    var type: ChartType
    var monthFilter: String
    var yearFilter: String
    
    init(type: ChartType, monthFilter: String, yearFilter: String, numberOfRecords: Int) {
        self.type = type
        self.monthFilter = monthFilter
        self.yearFilter = yearFilter
   
        var month: Int
        var year: Int = Int(yearFilter)
        
        switch monthFilter {
        case "January":
            month = 1
        case "February":
            month = 2
        case "March":
            month = 3
        case "April":
            month = 4
        case "May":
            month = 5
        case "June":
            month = 6
        case "July":
            month = 7
        case "August":
            month = 8
        case "September":
            month = 9
        case "October":
            month = 10
        case "November":
            month = 11
        case "December":
            month = 12
        default:
            month = 1
        }
        
        let startDate = DateComponents(year: year, month: month).date?.startDateOfMonth
        let endDate = DateComponents(year: year, month: month).date?.endDateOfMonth
        let predicate = NSPredicate(format: "%K >= %@ && %K <= %@", "dateMeasured", startDate as NSDate, "dateMeasured", endDate as NSDate)
        
        let fetchRequest: NSFetchRequest<GTGlucoseMeasurement> = GTGlucoseMeasurement.fetchRequest()
        fetchRequest.sortDescriptors = [ NSSortDescriptor(keyPath: \GTGlucoseMeasurement.measurementTakenAt, ascending: true) ]
        fetchRequest.fetchLimit = numberOfRecords
        
        self._measurements = FetchRequest<GTGlucoseMeasurement>(fetchRequest: fetchRequest, animation: .default)
    }
    
    var body: some View {
        Chart {
            ForEach(measurements) { level in
                if type == .bar {
                    BarMark(
                        x: .value("Date Measured", level.formattedMeasurementDate),
                        y: .value("Blood Sugar Level", level.value)
                    )
                    .foregroundStyle(getColorBy(value: level.value))
                } else {
                    LineMark(
                        x: .value("Date Measured", level.formattedMeasurementDate),
                        y: .value("Blood Sugar Level", level.value)
                    )
                    .foregroundStyle(getColorBy(value: level.value))
                }
            }
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

