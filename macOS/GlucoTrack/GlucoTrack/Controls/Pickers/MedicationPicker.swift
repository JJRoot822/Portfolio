//
//  MedicationPicker.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/7/24.
//

import SwiftUI
import CoreData

struct MedicationPicker: View {
    @FetchRequest(
        sortDescriptors: [],
        animation: .default
    ) private var medications: FetchedResults<GTMedication>
    
    @Binding var selection: GTMedication?
    
    var body: some View {
        Picker("Medication", selection: $selection) {
            ForEach(medications, id: \.id) { medication in
                Text(medication.medicationName).tag(medication)
            }
        }
    }
}
