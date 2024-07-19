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
    
    var integerFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        
        return formatter
    }
    
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
            
            HStack(spacing: 5) {
                Text("Max Records")
                
                TextField("Number of Records", value: $numberOfRecords, formatter: integerFormatter)
                    .accessibilityLabel(Text("Max Records"))
                
                Stepper {
                    Text("Number of Records")
                }onIncrement: {
                    numberOfRecords += 1
                } onDecrement: {
                    if numberOfRecords > 0 {
                        numberOfRecords -= 1
                    }
                }
                .labelsHidden()
                .accessibilityValue(Text("\(numberOfRecords) Records"))
            }
        }
    }
}
