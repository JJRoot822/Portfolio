//
//  MedicationDataList.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/6/24.
//

import SwiftUI
import CoreData

struct MedicationDataList: View {
    @FetchRequest private var medications: FetchedResults<GTMedication>
    
    var searchTerm: String
    var sortOrder: MedicationSortOrder
    
    init(searchTerm: String, sortOrder: MedicationSortOrder) {
        self.searchTerm = searchTerm
        self.sortOrder = sortOrder
        
        let request = GTMedication.fetchRequest()
        let predicate = NSPredicate(format: "name contains %@", searchTerm)
        
        if !searchTerm.isEmpty {
            request.predicate = predicate
        }
        
        switch sortOrder {
        case .nameAscending:
            request.sortDescriptors = [ NSSortDescriptor(keyPath: \GTMedication.name, ascending: true) ]
        case .nameDescending:
            request.sortDescriptors = [ NSSortDescriptor(keyPath: \GTMedication.name, ascending: false) ]
        case .datePrescribedAscending:
            request.sortDescriptors = [ NSSortDescriptor(keyPath: \GTMedication.datePrescribed, ascending: true) ]
        case .datePrescribedDescending:
            request.sortDescriptors = [ NSSortDescriptor(keyPath: \GTMedication.datePrescribed, ascending: false) ]
        }
        
        self._medications = FetchRequest(fetchRequest: request, animation: .default)
    }
    
    var body: some View {
        List {
            ForEach(medications, id: \.id) { medication in
                MedicationCell(medication: medication)
            }
        }
    }
}

