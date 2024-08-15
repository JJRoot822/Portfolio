//
//  EditWeightScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/13/24.
//

import SwiftUI
import CoreData

struct EditWeightScreen: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: ViewModel
    
    var weight: GTWeight
    
    init(weight: GTWeight) {
        self.weight = weight
        
        let unit: WeightUnit
        
        if weight.weightUnit == WeightUnit.pounds.rawValue {
            unit = .pounds
        } else if weight.weightUnit == WeightUnit.kilograms.rawValue {
            unit = .kilograms
        } else {
            unit = .stone
        }
        
        let viewModel = ViewModel(weight: weight.value, dateWeighed: weight.dateMeasured, unit: unit)
        
        self._viewModel = State(wrappedValue: viewModel)
    }
    
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
            
            Button("Save Changes") {
                viewModel.updateWeight(context: context, oldWeight: weight)
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
