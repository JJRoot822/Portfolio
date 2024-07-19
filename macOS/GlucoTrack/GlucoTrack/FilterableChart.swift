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
    var rangeStartDate: Date
    var rangeEndDate: Date
    
    init(type: ChartType, rangeStartDate: Date, rangeEndDate: Date, numberOfRecords: Int) {
        self.type = type
        self.rangeStartDate = rangeStartDate
        self.rangeEndDate = rangeEndDate
        
        let startDate = rangeStartDate as NSDate
        let endDate = rangeEndDate as NSDate
        let predicate = NSPredicate(format: "%K >= %@ && %K <= %@", "dateMeasured", startDate, "dateMeasured", endDate)
        
        let fetchRequest: NSFetchRequest<GTGlucoseMeasurement> = GTGlucoseMeasurement.fetchRequest()
        fetchRequest.sortDescriptors = [ NSSortDescriptor(keyPath: \GTGlucoseMeasurement.dateMeasured, ascending: true) ]
        fetchRequest.fetchLimit = numberOfRecords
        fetchRequest.predicate = predicate
        
        self._measurements = FetchRequest<GTGlucoseMeasurement>(fetchRequest: fetchRequest, animation: .default)
    }
    
    var body: some View {
        Chart {
            ForEach(measurements) { level in
                if type == .bar {
                    BarMark(
                        x: .value("Date Measured", level.formattedMeasurementDate),
                        y: .value("Blood Sugar Level", level.value),
                        width: 50
                    )
                    .foregroundStyle(getColorBy(value: level.value).gradient)
                } else {
                    LineMark(
                        x: .value("Date Measured", level.formattedMeasurementDate),
                        y: .value("Blood Sugar Level", level.value)
                    )
                    .foregroundStyle(getColorBy(value: level.value))
                }
            }
        }
        .chartXAxis(.visible)
        .chartYAxis(.visible)
        .chartScrollableAxes(.horizontal)
        .overlay {
            if measurements.isEmpty {
                Text("No Data to Display")
                    .font(.largeTitle)
                    .foregroundStyle(Color.secondary)
                
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

