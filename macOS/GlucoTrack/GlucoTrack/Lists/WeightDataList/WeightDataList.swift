//
//  WeightDataList.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/13/24.
//

import CoreData
import SwiftUI

struct WeightDataList: View {
    @FetchRequest private var weightLogs: FetchedResults<GTWeight>
    
    var sortOrder: WeightDataSortOrder
    
    init(sortOrder: WeightDataSortOrder) {
        self.sortOrder = sortOrder
        
        let request = GTWeight.fetchRequest()
        switch sortOrder {
        case .dateWeighedAscending:
            request.sortDescriptors = [ NSSortDescriptor(keyPath: \GTWeight.dateMeasured, ascending: true) ]
        case .dateWeighedDescending:
            request.sortDescriptors = [ NSSortDescriptor(keyPath: \GTWeight.dateWeighed, ascending: false) ]
        }
        
        self._weightLogs = FetchRequest(fetchRequest: request, animation: .default)
    }
    
    var body: some View {
        List {
            ForEach(weightLogs, id: \.id) { log in
                WeightCell(weight: log)
            }
        }
    }
}
