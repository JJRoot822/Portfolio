//
//  Sidebar.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/30/24.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        List {
            NavigationLink(value: 0) {
                Label("Blood Sugar", systemImage: "drop")
            }
            
            NavigationLink(value: 1) {
                Label("Medication", systemImage: "pills")
            }
            
            NavigationLink(value: 2) {
                Label("Weight", systemImage: "scalemass")
            }
            
            NavigationLink(value: 3) {
                Label("Reminders", systemImage: "alarm")
            }
            
            NavigationLink(value: 4) {
                Label("Settings", systemImage: "gearshape")
            }
        }
        .listStyle(.sidebar)
        .navigationDestination(for: Int.self) { value in
            switch value {
            case 0:
                BloodGlucoseMeasurementsScreen()
            case 1:
                MedicationsScreen()
            case 2:
                WeightMeasurementsScreen()
            case 3:
                RemindersScreen()
            default:
                EmptyView()
            }
        }
    }
}
