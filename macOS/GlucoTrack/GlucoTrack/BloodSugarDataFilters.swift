//
//  BloodSugarDataFilters.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/27/24.
//

import SwiftUI

struct BloodSugarDataFilters: View {
    @Binding var chartType: ChartType
    @Binding var rangeStartDate: Date
    @Binding var rangeEndDate: Date
    @Binding var numberOfRecords: Int
    
    var body: some View {
        HStack(spacing: 20) {
            Picker("Chart Type", selection: $chartType) {
                Text("Bar Chart").tag(ChartType.bar)
                Text("Line Chart").tag(ChartType.line)
            }
            .pickerStyle(.radioGroup)
            .horizontalRadioGroupLayout()
            
            DatePicker("Range Start Date", selection: $rangeStartDate, displayedComponents: [ .date, .hourAndMinute ])
            DatePicker("Range End Date", selection: $rangeEndDate, displayedComponents: [ .date, .hourAndMinute ])
            
            Stepper {
                Text("Max Number of Records")
            }onIncrement: {
                numberOfRecords += 1
            } onDecrement: {
                if numberOfRecords > 0 {
                    numberOfRecords -= 1
                }
            }
            .accessibilityValue(Text("\(numberOfRecords) Records"))
        }
    }
}
