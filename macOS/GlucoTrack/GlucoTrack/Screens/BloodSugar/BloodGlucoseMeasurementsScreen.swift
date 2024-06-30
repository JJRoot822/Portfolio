//
//  BloodGlucoseMeasurementsScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/31/24.
//

import SwiftUI
import CoreData

enum DataDisplayMode {
    case table, chart
}

struct BloodGlucoseMeasurementsScreen: View {
    @State private var searchTerm: String = ""
    @State private var isSearchPresented: Bool = false
    @State private var chartType: ChartType = .line
    @State private var rangeStartDate: Date = Calendar.current.date(byAdding: .day, value: -365, to: Date.now)!
    @State private var rangeEndDate: Date = Calendar.current.date(byAdding: .day, value: 365, to: Date.now)!
    @State private var numberOfRecords: Int = 25
    
    @AppStorage(Constants.bloodGlucoseDisplayModeKey) var displayMode: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                BloodSugarDataFilters(chartType: $chartType, rangeStartDate: $rangeStartDate, rangeEndDate: $rangeEndDate, numberOfRecords: $numberOfRecords)
                
                Picker("Data Display Mode", selection: $displayMode) {
                    Label("Show in a Table", systemImage: "tablecells").tag(DataDisplayMode.table)
                        .labelStyle(.iconOnly)
                        .tag(0)
                    
                    Label("Show in a Chart", systemImage: chartType == .bar ? "chart.bar" : "chart.line.uptrend.xyaxis")
                        .labelStyle(.iconOnly)
                        .tag(1)
                }
                .pickerStyle(.segmented)
                .labelsHidden()
            }
            
            if displayMode == 0 {
                FilterableTable(rangeStartDate: rangeStartDate, rangeEndDate: rangeEndDate, numberOfRecords: numberOfRecords, searchTerm: searchTerm)
            } else {
                FilterableChart(type: chartType, rangeStartDate: rangeStartDate, rangeEndDate: rangeEndDate, numberOfRecords: numberOfRecords)
            }
        }
        .padding()
        .searchable(text: $searchTerm, isPresented: $isSearchPresented)
    }
}

