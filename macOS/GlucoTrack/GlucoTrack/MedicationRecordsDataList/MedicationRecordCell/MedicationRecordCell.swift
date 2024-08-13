//
//  MedicationRecordCell.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/13/24.
//

import SwiftUI
import CoreData

struct MedicationRecordCell: View {
    @Environment(\.managedObjectContext) var context
    @State private var viewModel = ViewModel()
    
    var record: GTMedicationRecord
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                if let medication = record.medication {
                    Text("\(medication.medicationName)")
                } else {
                    Text("Unknown Medication")
                }
                
                Text("Dose Taken: \(record.doseAmountTaken) \(record.dosageUnit)")
                    .foregroundStyle(.secondary)
                
                Text("\(record.consumptionNotes)")
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
                .frame(minWidth: 20, maxWidth: .infinity)
            
            Text(record.formattedDateTaken)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button {
                viewModel.toggleShowEditMedicationRecordScreen()
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
        .confirmationDialog("Are you sure you want to delete this log entry?", isPresented: $viewModel.isDeleteRequested) {
            Button("Delete", role: .destructive){
                viewModel.delete(record, context: context)
                // viewModel.id = UUID()
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleIsDeleteRequested)
        }
        .alert(isPresented: $viewModel.isShowingError, error: viewModel.error) { error in
            Text(error.failureReason!)
        } message: { error in
            Text(error.errorDescription!)
        }
        .sheet(isPresented: $viewModel.isShowingEditMedicationRecordScreen) {
            viewModel.id = UUID()
        } content: {
            EditMedicationRecordScreen(record: record)
        }
    }
}
