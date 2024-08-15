//
//  WeightMeasurementsScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/13/24.
//

import SwiftUI

struct WeightMeasurementsScreen: View {
    @State private var sortOrder: WeightDataSortOrder = .dateWeighedAscending
    
    var body: some View {
        WeightDataList(sortOrder: sortOrder)
            .toolbar {
                Picker("Weight Sort Order", selection: $sortOrder) {
                    Text("Date Weighed (Ascending)").tag(WeightDataSortOrder.dateWeighedAscending)
                    Text("Date Weighed (Descending)").tag(WeightDataSortOrder.dateWeighedDescending)
                }
            }
    }
}
