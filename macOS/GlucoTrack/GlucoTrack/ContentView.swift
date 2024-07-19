//
//  ContentView.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/26/24.
//

import SwiftUI
import CoreData

struct MedicationsScreen: View {
    var body: some View {
        Text("")
    }
}

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
    
    var body: some View {
        NavigationSplitView(sidebar: {
            Sidebar()
        },detail: {
            BloodGlucoseMeasurementsScreen()
                .id(id)
        })
        .sheet(isPresented: $globalState.showAddBloodSugarReading, onDismiss: {
            id = UUID()
        }) {
            AddBloodSugarReadingScreen()
        }
        .touchBar {
            CreateActionsMenu()
            SettingsLink {
                Label("Settings", systemImage: "gear")
            }
        }
        .toolbar {
            CreateActionsMenu()
            
            SettingsLink {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}

