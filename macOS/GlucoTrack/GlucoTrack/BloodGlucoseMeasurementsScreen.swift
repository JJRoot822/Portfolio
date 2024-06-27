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
    @State private var searchTerm: String = ""
    @State private var isSearchPresented: Bool = false
    @State private var selection: ChartType = .line
    @State private var monthFilter: String = "January"
    @State private var yearFilter: String = String(Calendar.current.dateComponents([ .year ], from: Date()).year!)
    
    let monthOptions = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ]
    
    var yearIntervalPickerOptions: [String] {
        let currentYear = Calendar.current.dateComponents([ .year ], from: Date()).year!
        var years: [String] = []
    
        for i in 0..<11 {
            years.append(String(currentYear - i))
        }
        
        return years
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                Picker("Chart Type", selection: $selection) {
                    Text("Bar Chart").tag(ChartType.bar)
                    Text("Line Chart").tag(ChartType.line)
                }
                .pickerStyle(.radioGroup)
                .horizontalRadioGroupLayout()
                
                Picker("Month Filter", selection: $monthFilter) {
                    ForEach(monthOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                
                Picker("Year filter", selection: $yearFilter) {
                    ForEach(yearIntervalPickerOptions, id: \.self) { option in
                        Text(option)
                    }
                }
            }
            
            Table(measurements) {
                TableColumn("Glucose Level", value: \.formattedMeasurement)
                TableColumn("Unit", value: \.measurementUnit)
                TableColumn("Date Measured", value: \.formattedMeasurementDate)
                TableColumn("Notes", value: \.userNotes)
            }
            
            FilterableChart(type: selection, monthFilter: monthFilter, yearFilter: yearFilter, numberOfRecords: numberOfRecords)
        }
        .padding()
        .searchable(text: $searchTerm, isPresented: $isSearchPresented)
    }
}

