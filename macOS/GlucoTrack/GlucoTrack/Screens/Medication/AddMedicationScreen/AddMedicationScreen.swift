//
//  AddMedicationScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/29/24.
//

import SwiftUI
import CoreData

struct AddMedicationScreen: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        Form {
            TextField("Medication Name", text: $viewModel.name)
            
            HStack(spacing: 20) {
                HStack(spacing: 5) {
                    TextField("Medication Dosage", value: $viewModel.dosageValue, formatter: viewModel.dosageFormatter)
                    
                    Stepper(label: {
                        Text("Medication Dosage")
                    }, onIncrement: viewModel.incrementDosage, onDecrement: viewModel.decrementDosage)
                    .labelsHidden()
                    .accessibilityValue(Text("\(NSNumber(value: viewModel.dosageValue), formatter: viewModel.dosageFormatter) \(viewModel.dosageUnit)"))
                }
                
                TextField("Dosage Unit", text: $viewModel.dosageUnit)
            }
            
            DatePicker("Date Prescribed", selection: $viewModel.datePrescribed, displayedComponents: [ .date ])
            
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
            
            Button("Cancel", role: .cancel) {
                dismiss()
            }
            
            Button("Add Medication") {
                viewModel.addMedication(context: context)
            }
            .tint(Color.accentColor)
        }
        .touchBar {
            Button("Cancel", role: .cancel) {
                dismiss()
            }
            
            Button("Add Medication") {
                viewModel.addMedication(context: context)
            }
            .tint(Color.accentColor)
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
