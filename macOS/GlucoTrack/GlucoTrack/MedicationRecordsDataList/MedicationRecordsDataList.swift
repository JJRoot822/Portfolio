//
//  MedicationRecordsDataList.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/13/24.
//

import SwiftUI
import CoreData

struct MedicationRecordsDataList: View {
    @FetchRequest private var medicationLogs: FetchedResults<GTMedicationRecord>
    
    var searchTerm: String
    var sortOrder: MedicationRecordSortOrder
    
    init(searchTerm: String, sortOrder: MedicationRecordSortOrder) {
        self.searchTerm = searchTerm
        self.sortOrder = sortOrder
        
        let request = GTMedicationRecord.fetchRequest()
        
        switch sortOrder {
        case .dateAscending:
            request.sortDescriptors = [ NSSortDescriptor(keyPath: \GTMedicationRecord.dateTaken, ascending: true) ]
        case .dateDescending:
            request.sortDescriptors = [ NSSortDescriptor(keyPath: \GTMedicationRecord.dateTaken, ascending: false) ]
        }
        
        self._medicationLogs = FetchRequest(fetchRequest: request, animation: .default)
    }
    
    var filteredLogs: [GTMedicationRecord] {
        guard !searchTerm.isEmpty else {
            return medicationLogs.map { $0 }
        }
        
        return medicationLogs.filter { log in
            guard let medication = log.medication else {
                return true
            }
            
            return medication.medicationName.contains(searchTerm)
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredLogs, id: \.id) { log in
                MedicationRecordCell(record: log)
            }
        }
    }
}
