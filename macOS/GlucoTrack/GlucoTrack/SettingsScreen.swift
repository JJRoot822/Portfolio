//
//  SettingsScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/31/24.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var isShowingError: Bool = false
    
    @AppStorage(Constants.inRangeLowerBoundKey) var inRangeLowerBound: Double = 70.0
    @AppStorage(Constants.inRangeUpperBoundKey) var inRangeUpperBound: Double = 120.0
    @AppStorage(Constants.tooLowUpperBoundKey) var tooLowUpperBound: Double = 65.0
    @AppStorage(Constants.tooHighLowerBoundKey) var tooHighLowerBound: Double = 160.0
    @AppStorage(Constants.bloodGlucoseUnitKey) var bloodGlucoseUnit = "mg/dL"
    @AppStorage(Constants.weightUnitKey) var weightUnit = "lbs"
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        
        return formatter
    }()
    
    var body: some View {
        Form {
            TextField("Lower Bound of In-Range Blood Sugar Levels", value: $inRangeLowerBound, formatter: formatter)
            TextField("Upper Bound of In-Range Blood Sugar Levels", value: $inRangeUpperBound, formatter: formatter)
            TextField("Upper Bound of Too Low Blood Sugar Levels", value: $tooLowUpperBound, formatter: formatter)
            TextField("Lower Bound of Too High Blood Sugar Levels", value: $tooHighLowerBound, formatter: formatter)
            
            Picker("Unit of Measurement for Blood Sugar Levels", selection: $bloodGlucoseUnit) {
                Text("Milligrams Per Deciliter").tag("mg/dL")
                Text("Millimoles Per Liter").tag("mmol/L")
            }
            
            Picker("Unit of Measurement for Weight", selection: $weightUnit) {
                Text("Pounds").tag("lbs")
                Text("Kilograms").tag("kg")
            }
            
            Button("Done", action: close)
        }
        .alert(isPresented: $isShowingError) {
            Alert(title: Text("Error: Blood sugar range limits are invalid"), 
                  message: Text(Constants.invalidRangesErrorMessage),
                  primaryButton: .default(Text("Reset Defaults"), action: reset),
                  secondaryButton: .cancel())
        }
    }
    
    private func close() {
        if tooLowUpperBound < inRangeLowerBound &&
           inRangeLowerBound < inRangeUpperBound &&
           tooHighLowerBound > inRangeUpperBound {
            dismiss()
            
            return
        }
        
        isShowingError = true
    }
    
    private func reset() {
        inRangeLowerBound = 70.0
        inRangeUpperBound = 120.0
        tooLowUpperBound = 65.0
        tooHighLowerBound = 160.0
    }
}
