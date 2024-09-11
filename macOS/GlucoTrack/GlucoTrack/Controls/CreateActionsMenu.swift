//
//  CreateActionsMenu.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/27/24.
//

import SwiftUI

struct CreateActionsMenu: View {
    @EnvironmentObject private var globalState: GlobalState
    
    var body: some View {
        Menu(content: {
            Button("Add Blood Glucose Measurement") {
                globalState.showAddBloodSugarReading = true
            }
            
            Button("Add Medication") {
                globalState.showAddMedication = true
            }
            
            Button("Add Medication Consumption Record") {
                globalState.showAddMedConsumptionRecord = true
            }
            
            Button("Add a Weight Record") {
                globalState.showAddWeightRecord = true
            }
        }) {
            Label("Add", systemImage: "plus")
        }
    }
}
