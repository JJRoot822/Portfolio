//
//  GlucoTrackApp.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/26/24.
//

import SwiftUI

@main
struct GlucoTrackApp: App {
    @StateObject private var globalState = GlobalState()
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 1280, height: 720)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(globalState)
        }
        .commands {
            CommandGroup(replacing: .help) {
                EmptyView()
            }
            
            CommandGroup(replacing: .importExport) {
                EmptyView()
            }
            
            CommandGroup(replacing: .sidebar) {
                EmptyView()
            }
            
            CommandGroup(replacing: .toolbar) {
                EmptyView()
            }
            
            CommandGroup(replacing: .systemServices) {
                EmptyView()
            }
            
            CommandGroup(replacing: .windowList) {
                EmptyView()
            }
            
            CommandGroup(replacing: .newItem) {
                Menu(content: {
                    Button("Add Blood Glucose Measurement") {
                        globalState.showAddBloodSugarReading = true
                    }
                    .keyboardShortcut("B", modifiers: [ .command ])
                    
                    Button("Add Medication") {
                        globalState.showAddMedication = true
                    }
                    .keyboardShortcut("M", modifiers: [ .control ])
                    
                    Button("Add Medication Consumption Record") {
                        globalState.showAddMedConsumptionRecord = true
                    }
                    .keyboardShortcut("R", modifiers: [ .command ])
                    
                    Button("Add a Weight Record") {
                        globalState.showAddWeightRecord = true
                    }
                    .keyboardShortcut("R", modifiers: [ .command, .shift ])
                    
                    Button("Add Medication Reminder") {
                        globalState.showAddMedicationReminder = true
                    }
                    .keyboardShortcut("R", modifiers: [ .command, .option, .shift ])
                }) {
                    Text("New...")
                }
            }
        }
        
        Settings {
            SettingsScreen()
        }
    }
}
