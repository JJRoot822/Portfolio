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
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        
        return formatter
    }()
    
    var body: some View {
        Form {
            HStack {
                TextField("Lower Bound of In-Range Blood Sugar Levels", value: $inRangeLowerBound, formatter: formatter)
                
                HSlider(value: $inRangeLowerBound, label: "Lower Bound of In-Range Blood Sugar Levels", min: tooLowUpperBound + 0.1, max: inRangeUpperBound - 0.1)
            }
            
            HStack {
                TextField("Upper Bound of In-Range Blood Sugar Levels", value: $inRangeUpperBound, formatter: formatter)
                
                HSlider(value: $inRangeUpperBound, label: "Upper Bound of In-Range Blood Sugar Levels", min: inRangeLowerBound + 0.1, max: tooHighLowerBound - 0.1)
            }
            
            HStack {
                TextField("Upper Bound of Too Low Blood Sugar Levels", value: $tooLowUpperBound, formatter: formatter)
                
                HSlider(value: $tooLowUpperBound, label: "Upper Bound of Too Low Blood Sugar Levels", min: 0, max: inRangeLowerBound - 0.1)
            }
            
            HStack {
                TextField("Lower Bound of Too High Blood Sugar Levels", value: $tooHighLowerBound, formatter: formatter)
            
                HSlider(value: $tooHighLowerBound, label: "Lower Bound of Too High Blood Sugar Levels", min: inRangeUpperBound + 0.1, max: 750)
            }
            
            HStack {
                Spacer()
                Button("Reset Defaults", action: reset)
                Button("Done", action: close)
            }
        }
        .padding(20)
        .presentationSizing(.fitted)
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
