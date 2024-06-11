//
//  BloodGlucoseMeasurementsScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/31/24.
//

import SwiftUI
import CoreData
import Charts

enum ChartType {
    case bar, line
}

struct BloodGlucoseMeasurementsScreen: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \GTGlucoseMeasurement.dateMeasured, ascending: false)
        ],
        animation: .default
    ) private var measurements: FetchedResults<GTGlucoseMeasurement>


    @AppStorage("gt-in-range-lower-bound") var inRangeLowValue: Double = 70.0
    @AppStorage("gt-in-range-upper-bound") var inRangeHighValue: Double = 120.0
    @AppStorage("gt-too-low-upper-bound") var tooLowHighValue: Double = 69.9
    @AppStorage("gt-too-high-lower-bound") var tooHighLowValue: Double = 160.0
    
    @State private var selection: ChartType = .line
    
    var body: some View {
        VStack(spacing: 20) {
            Table(measurements) {
                TableColumn("Glucose Level", value: \.formattedMeasurement)
                TableColumn("Unit", value: \.measurementUnit)
                TableColumn("Date Measured", value: \.formattedMeasurementDate)
                TableColumn("Notes", value: \.userNotes)
            }
            
            VStack(spacing: 10) {
                Picker("Chart Type", selection: $selection) {
                    Text("Bar Chart").tag(ChartType.bar)
                    Text("Line Chart").tag(ChartType.line)
                }
                .pickerStyle(.segmented)
                
                Chart {
                    ForEach(measurements) { level in
                        if selection == .bar {
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
                        }
                    }
                }
            }
            
        }
        .padding()
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
