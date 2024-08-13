//
//  AddMedicationRecordScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/7/24.
//

import SwiftUI
import CoreData

struct AddMedicationRecordScreen: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        Form {
            MedicationPicker(selection: $viewModel.medication)
            
            HStack {
                TextField("Dosage Taken", value: $viewModel.doseTaken, formatter: viewModel.dosageFormatter)
                    .accessibilityLabel(Text("Dosage Taken"))
                
                Stepper(label: {
                    Text("DoseTaken")
                }, onIncrement: viewModel.incrementDoseTaken, onDecrement: viewModel.decrementDoseTaken)
                .labelsHidden()
                .accessibilityValue(Text("\(NSNumber(value: viewModel.doseTaken), formatter: viewModel.dosageFormatter)"))
                
                Text(viewModel.medication?.dosageUnit ?? "")
            }
            
            DatePicker("Date Taken", selection: $viewModel.dateTaken, displayedComponents: [ .date, .hourAndMinute ])
        
            HStack {
                TextField("Notes", text: $viewModel.notes)
                                    .onChange(of: viewModel.notes) {
                                        withAnimation(.spring) {
                                            viewModel.charactersInNote = viewModel.notes.count
                                        }
                                    }
                                Gauge(value: Double(viewModel.charactersInNote), in: 0...150) {
                                    Text("\(150 - viewModel.charactersInNote) characters left")
                                }
                                .labelsHidden()
                                .tint(viewModel.gaugeColor(viewModel.charactersInNote))
            }
            
            HStack {
                Button("Cancel", role: .cancel) {
                                dismiss()
                            }
                            
                            Button("Add Medication Record") {
                                viewModel.addMedicationRecord(context: context)
                            }
            }
        }
        .onChange(of: viewModel.shouldDismiss) {
            if viewModel.shouldDismiss {
                dismiss()
            }
        }
        .alert(isPresented: $viewModel.isShowingError, error: viewModel.error) { _ in
            Button("Ok") {
                viewModel.isShowingError = false
            }
        } message: { error in
            Text(error.failureReason!)
        }
    }
}
