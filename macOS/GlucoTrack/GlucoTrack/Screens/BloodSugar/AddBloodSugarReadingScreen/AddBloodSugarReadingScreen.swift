//
//  AddBloodSugarReadingScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/29/24.
//

import SwiftUI
import CoreData

struct AddBloodSugarReadingScreen: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        Form {
            HStack(spacing: 20) {
                HStack(spacing: 5) {
                    TextField("Blood Sugar Level", value: $viewModel.level, formatter: viewModel.levelFormatter)
                    
                    Stepper(label: {
                        Text("Blood Sugar Level")
                    }, onIncrement: viewModel.incrementLevel, onDecrement: viewModel.decrementLevel)
                    .labelsHidden()
                    .accessibilityValue(Text("\(NSNumber(value: viewModel.level), formatter: viewModel.levelFormatter) \(viewModel.fullUnitOfMeasure(from: viewModel.unit))"))
                }
                
                Picker("Unit of Measure", selection: $viewModel.unit) {
                    Text("Millimoles Per Liter").tag("mmol/L")
                    Text("Milligrams Per Deciliter").tag("mg/dL")
                }
                .labelsHidden()
            }
            
            DatePicker("Date Measured", selection: $viewModel.dateMeasured, displayedComponents: [ .date, .hourAndMinute ])
            
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
            
            Button("Add Reading") {
                viewModel.addReading(context: context)
            }
            .tint(Color.accentColor)
        }
        .touchBar {
            Button("Cancel", role: .cancel) {
                dismiss()
            }
            
            Button("Add Reading") {
                viewModel.addReading(context: context)
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
