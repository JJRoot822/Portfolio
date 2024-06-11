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
    var body: some View {
        NavigationSplitView(sidebar: {
            Sidebar()
        },detail: {
            Text("Nothing to Show Right Now. Select an Option in the Sidebar to Get Started")
        })
        .toolbar {
            Menu(content: {
                Button("Add Blood Glucose Measurement") {
                    
                }
                
                Button("Add Medication") {
                    
                }
                
                Button("Add Medication Consumption Record") {
                    
                }
                
                Button("Add a Weight Record") {
                    
                }
            }) {
                Label("Add", systemImage: "plus")
            }
            
            SettingsLink {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}

