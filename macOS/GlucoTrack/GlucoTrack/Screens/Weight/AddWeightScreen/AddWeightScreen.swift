//
//  AddWeightScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/13/24.
//

import SwiftUI
import CoreData

struct AddWeightScreen: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        Form {
            HStack(spacing: 20) {
                HStack(spacing: 5) {
                    TextField("Weight", value: $viewModel.weight, formatter: viewModel.weightFormatter)
                    
                    Stepper(label: {
                        Text("Weight")
                    }, onIncrement: viewModel.incrementWeight, onDecrement: viewModel.decrementWeight)
                    .labelsHidden()
                    .accessibilityValue(Text("\(NSNumber(value: viewModel.weight), formatter: viewModel.weightFormatter)"))
                }
                
                Picker("Unit of Measure", selection: $viewModel.unit) {
                    Text("Pounds").tag(WeightUnit.pounds)
                    Text("Kilograms").tag(WeightUnit.kilograms)
                    Text("Stone").tag(WeightUnit.stone)
                }
                .labelsHidden()
            }
            
            DatePicker("Date Weighed", selection: $viewModel.dateWeighed, displayedComponents: [ .date ])
            
            Button("Cancel", role: .cancel) {
                dismiss()
            }
            
            Button("Add Weight") {
                viewModel.addWeight(context: context)
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
