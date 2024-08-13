//
//  MedicationsScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 7/24/24.
//

import SwiftUI

struct MedicationsScreen: View {
    @State private var sortOrder: MedicationSortOrder = .nameAscending
    @State private var searchTerm: String = ""
    
    var body: some View {
        MedicationDataList(searchTerm: searchTerm, sortOrder: sortOrder)
            .searchable(text: $searchTerm, prompt: Text("Search for a Medication"))
            .toolbar {
                Picker("Medication Sort Order", selection: $sortOrder) {
                    Text("Name (Ascending)").tag(MedicationSortOrder.nameAscending)
                    Text("Name (Descending)").tag(MedicationSortOrder.nameDescending)
                    Text("Date Prescribed (Ascending)").tag(MedicationSortOrder.datePrescribedAscending)
                    Text("Date Prescribed (Descending)").tag(MedicationSortOrder.datePrescribedDescending)
                }
            }
    }
}
