//
//  ContentView.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/26/24.
//

import SwiftUI
import CoreData
import LocalAuthentication

struct WeightMeasurementsScreen: View {
    var body: some View {
        Text("")
    }
}

struct RemindersScreen: View {
    var body: some View {
        Text("")
    }
}

struct ContentView: View {
    @EnvironmentObject var globalState: GlobalState
    
    @State private var id: UUID = UUID()
    @State private var wasSuccessful: Bool = false
    
    var body: some View {
        ZStack {
            if !wasSuccessful {
                Text("Failed to unlock your data")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
            } else {
                TabView {
                    Tab("Blood Sugar", systemImage: "drop") {
                        BloodGlucoseMeasurementsScreen()
                            .id(id)
                    }
                    
                    Tab("Medications", systemImage: "pills") {
                        MedicationsScreen()
                            .id(id)
                    }
                    
                    Tab("Consumption", systemImage: "list.clipboard") {
                        MedicationRecordsScreen()
                            .id(id)
                    }
                    
                    Tab("Weight", systemImage: "scalemass") {
                        WeightMeasurementsScreen()
                            .id(id)
                    }
                    
                    Tab("Reminders", systemImage: "alarm") {
                        RemindersScreen()
                            .id(id)
                    }
                }
                .tabViewStyle(.sidebarAdaptable)
                .sheet(isPresented: $globalState.showAddBloodSugarReading, onDismiss: {
                    id = UUID()
                }) {
                    AddBloodSugarReadingScreen()
                }
                .sheet(isPresented: $globalState.showAddMedication, onDismiss: {
                    id = UUID()
                }) {
                    AddMedicationScreen()
                }
                .touchBar {
                    CreateActionsMenu()
                    SettingsLink {
                        Label("Settings", systemImage: "gear")
                    }
                }
                .toolbar {
                    CreateActionsMenu()
                }
            }
        }
        .task {
            await authenticate()
        }
    }
    
    private func authenticate() async {
        wasSuccessful = await AuthenticationService().authenticate(using: .deviceOwnerAuthentication, for: "unlock your health data")
    }
}

