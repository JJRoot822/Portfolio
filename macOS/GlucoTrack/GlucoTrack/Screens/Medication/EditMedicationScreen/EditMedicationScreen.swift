//
//  EditMedicationScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/29/24.
//

import SwiftUI
import CoreData

struct EditMedicationScreen: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: ViewModel
    
    var medication: GTMedication
    
    init(medication: GTMedication) {
        self.medication = medication
    
        let viewModel = ViewModel(name: medication.medicationName, dosageValue: medication.doseValue, dosageUnit: medication.dosageUnit, datePrescribed: medication.originalPrescriptionDate, notes: medication.medicationNotes)
        self._viewModel = State(wrappedValue: viewModel)
    }
    
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
            
            Button("SaveChanges") {
                viewModel.updateMedication(context: context, medication: medication)
            }
            .tint(Color.accentColor)
        }
        .touchBar {
            Button("Cancel", role: .cancel) {
                dismiss()
            }
            
            Button("Save Changes") {
                viewModel.updateMedication(context: context, medication: medication)
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
