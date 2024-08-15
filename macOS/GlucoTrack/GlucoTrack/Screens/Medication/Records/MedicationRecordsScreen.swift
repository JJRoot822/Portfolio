//
//  MedicationRecordsScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/6/24.
//

import SwiftUI

struct MedicationRecordsScreen: View {
    @State private var sortOrder: MedicationRecordSortOrder = .dateAscending
    @State private var searchTerm: String = ""
    
    var body: some View {
        MedicationRecordsDataList(searchTerm: searchTerm, sortOrder: sortOrder)
        .searchable(text: $searchTerm, prompt: Text("Search for a Log Entry"))
            .toolbar {
                Picker("Medication Records Sort Order", selection: $sortOrder) {
                    Text("Date Taken (Ascending)").tag(MedicationRecordSortOrder.dateAscending)
                    Text("Date Taken (Descending)").tag(MedicationRecordSortOrder.dateDescending)
                }
            }
    }
}

