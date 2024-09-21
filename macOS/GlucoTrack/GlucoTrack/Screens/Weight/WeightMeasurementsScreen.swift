//
//  WeightMeasurementsScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/13/24.
//

import SwiftUI

struct WeightMeasurementsScreen: View {
    @State private var sortOrder: WeightDataSortOrder = .dateWeighedAscending
    @State private var filter: WeightUnit = .pounds
    
    var body: some View {
        Picker("Weight Unit", selection: $filter) {
            Text("Pounds").tag(WeightUnit.pounds)
            Text("Kilograms").tag(WeightUnit.kilograms)
            Text("Stone").tag(WeightUnit.stone)
        }
        .pickerStyle(.segmented)
        
        VSplitView {
            WeightDataList(sortOrder: sortOrder, filter: filter)
            WeightDataChart(filter: filter)
        }
            .toolbar {
                Picker("Weight Sort Order", selection: $sortOrder) {
                    Text("Date Weighed (Ascending)").tag(WeightDataSortOrder.dateWeighedAscending)
                    Text("Date Weighed (Descending)").tag(WeightDataSortOrder.dateWeighedDescending)
                }
            }
    }
}
