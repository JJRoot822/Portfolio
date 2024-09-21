//
//  WeightDataChart.swift
//  GlucoTrack
//
//  Created by Joshua Root on 9/12/24.
//

import SwiftUI
import Charts
import CoreData

struct WeightDataChart: View {
    @FetchRequest private var weightLogs: FetchedResults<GTWeight>

    var filter: WeightUnit
    
    init(filter: WeightUnit) {
        self.filter = filter
        
        let request = GTWeight.fetchRequest()
        request.sortDescriptors = [ NSSortDescriptor(keyPath: \GTWeight.dateWeighed, ascending: true) ]
        request.predicate = NSPredicate(format: "unit == %@", filter.rawValue)
        
        self._weightLogs = FetchRequest(fetchRequest: request, animation: .default)
    }
    
    var body: some View {
        Chart {
            LinePlot(
                weightLogs,
                x: .value("Date Weighed", \.dateMeasured),
                y: .value("Weight", \.value)
            )
            .foregroundStyle(.blue)
        }
        .chartXAxis(.visible)
        .chartYAxis(.visible)
        .chartScrollableAxes([ .horizontal ])
        .overlay {
            if weightLogs.isEmpty {
                Text("No Data to Display")
                    .font(.largeTitle)
                    .foregroundStyle(Color.secondary)
                
            }
        }
    }
}
