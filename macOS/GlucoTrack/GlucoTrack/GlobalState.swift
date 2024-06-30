//
//  GlobalState.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/28/24.
//

import SwiftUI

class GlobalState: ObservableObject {
    @Published var showAddBloodSugarReading: Bool = false
    @Published var showAddMedication: Bool = false
    @Published var showAddMedConsumptionRecord: Bool = false
    @Published var showAddWeightRecord: Bool = false
    @Published var showAddMedicationReminder: Bool = false
}
