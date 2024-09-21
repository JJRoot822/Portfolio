//
//  BloodGlucoseMeasurementsScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/31/24.
//

import SwiftUI
import CoreData

struct BloodGlucoseMeasurementsScreen: View {
    @State private var searchTerm: String = ""
    @State private var isSearchPresented: Bool = false
    @State private var chartType: ChartType = .bar
    @State private var rangeStartDate: Date = Calendar.current.date(byAdding: .day, value: -365, to: Date.now)!
    @State private var rangeEndDate: Date = Calendar.current.date(byAdding: .day, value: 365, to: Date.now)!
    @State private var numberOfRecords: Int = 25
    @State private var filter: UnitOfMeasure = .milligramsPerDecilitre
    
    @AppStorage(Constants.bloodGlucoseDisplayModeKey) var displayMode: Int = 0
    
    var body: some View {
        VSplitView {
            VStack(spacing: 20) {
                BloodSugarDataFilters(chartType: $chartType, rangeStartDate: $rangeStartDate, rangeEndDate: $rangeEndDate, numberOfRecords: $numberOfRecords)
                
                
                Picker("Blood Sugar Unit", selection: $filter) {
                    Text("Milligrams Per Deciliter").tag(UnitOfMeasure.milligramsPerDecilitre)
                    Text("Millimoles Per Liter").tag(UnitOfMeasure.millimolesPerLitre)
                }
                .pickerStyle(.segmented)
                
                GlucoseDataList(rangeStartDate: rangeStartDate, rangeEndDate: rangeEndDate, numberOfRecords: numberOfRecords, searchTerm: searchTerm, filter: filter)
            }
            .padding(5)
            
            GlucoseDataChart(type: chartType, rangeStartDate: rangeStartDate, rangeEndDate: rangeEndDate, numberOfRecords: numberOfRecords, filter: filter)
                .padding(5)
        }
        .searchable(text: $searchTerm, isPresented: $isSearchPresented)
    }
}

