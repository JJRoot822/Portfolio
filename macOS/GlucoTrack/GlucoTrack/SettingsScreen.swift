//
//  SettingsScreen.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/31/24.
//

import SwiftUI

struct SettingsScreen: View {
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
            HStack(spacing: 5) {
                TextField("Lower Bound of In-Range Blood Sugar Levels", value: $inRangeLowerBound, formatter: formatter)
                
                Slider(value: $inRangeLowerBound, in: tooLowUpperBound + 0.1...inRangeUpperBound - 0.1, step: 0.1, label: {
                    Text("Lower Bound of In Range Blood Sugar Levels")
                })
                .labelsHidden()
            }
            
            HStack(spacing: 5) {
                TextField("Upper Bound of In-Range Blood Sugar Levels", value: $inRangeUpperBound, formatter: formatter)
                
                Slider(value: $inRangeUpperBound, in: inRangeLowerBound + 0.1...tooHighLowerBound - 0.1, step: 0.1, label: {
                    Text("Upper Bound of In Range Blood Sugar Levels")
                })
                .labelsHidden()
            }
            
            HStack(spacing: 5) {
                TextField("Upper Bound of Too Low Blood Sugar Levels", value: $tooLowUpperBound, formatter: formatter)
                
                Slider(value: $tooLowUpperBound, in: 0...inRangeLowerBound - 0.1, step: 0.1, label: {
                    Text("Upper Bound of Too Low Blood Sugar Levels")
                })
                .labelsHidden()
            }
            
            HStack(spacing: 5) {
                TextField("Lower Bound of Too High Blood Sugar Levels", value: $tooHighLowerBound, formatter: formatter)
                
                Slider(value: $tooHighLowerBound, in: inRangeUpperBound + 0.1...500, step: 0.1, label: {
                    Text("Lower Bound of Too High Blood Sugar Levels")
                })
                .labelsHidden()
            }
            
            Picker("Unit of Measurement for Blood Sugar Levels", selection: $bloodGlucoseUnit) {
                Text("Milligrams Per Deciliter").tag("mg/dL")
                Text("Millimoles Per Liter").tag("mmol/L")
            }
            
            Picker("Unit of Measurement for Weight", selection: $weightUnit) {
                Text("Pounds").tag("lbs")
                Text("Kilograms").tag("kg")
            }
        }
        .onChange(of: inRangeLowerBound, initial: true) {
            if inRangeLowerBound < tooLowUpperBound {
                tooLowUpperBound = inRangeLowerBound - 0.1
            }
            
            if inRangeLowerBound > inRangeUpperBound {
                inRangeUpperBound = inRangeLowerBound + 0.1
            }
        }
        .onChange(of: inRangeUpperBound, initial: true) {
            if inRangeUpperBound > tooHighLowerBound {
                tooHighLowerBound = inRangeUpperBound + 0.1
            }
            
            if inRangeUpperBound < inRangeLowerBound {
                inRangeLowerBound = inRangeUpperBound - 0.1
            }
        }
        .onChange(of: tooLowUpperBound, initial: true) {
            if tooLowUpperBound < 0 {
                tooLowUpperBound = 0
            }
            
            if tooLowUpperBound > inRangeLowerBound {
                inRangeLowerBound = tooLowUpperBound + 0.1
            }
        }
        .onChange(of: tooHighLowerBound, initial: true) {
            if tooHighLowerBound > 500 {
                tooHighLowerBound = 500
            }
            
            if tooHighLowerBound < inRangeUpperBound {
                inRangeUpperBound = tooHighLowerBound - 0.1
            }
        }
    }
}
