//
//  MedicationCell.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/6/24.
//

import SwiftUI

struct MedicationCell: View {
    @Environment(\.managedObjectContext) var context
    @State private var viewModel = ViewModel()
    
    var medication: GTMedication
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(medication.medicationName)
                
                Text("Prescribed on \(medication.formattedPrescriptionDate)")
                    .foregroundStyle(.secondary)
            }
            
            Text("\(medication.formattedDosageValue) \(medication.dosageUnit)")
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button {
                viewModel.toggleShowEditMedicationScreen()
            } label: {
                Label("Edit", systemImage: "pencil")
                    .labelStyle(.iconOnly)
            }
            .tint(.blue)
            
            Button(role: .destructive) {
                viewModel.toggleIsDeleteRequested()
            } label: {
                Label("Delete", systemImage: "trash")
                    .labelStyle(.iconOnly)
            }
        }
        .confirmationDialog("Are you sure you want to delete this medication?", isPresented: $viewModel.isDeleteRequested) {
            Button("Delete", role: .destructive){
                viewModel.delete(medication, context: context)
                // viewModel.id = UUID()
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleIsDeleteRequested)
        }
        .alert(isPresented: $viewModel.isShowingError, error: viewModel.error) { error in
            Text(error.failureReason!)
        } message: { error in
            Text(error.errorDescription!)
        }
        .sheet(isPresented: $viewModel.isShowingEditMedicationScreen) {
            viewModel.id = UUID()
        } content: {
            EditMedicationScreen(medication: medication)
        }
    }
}
