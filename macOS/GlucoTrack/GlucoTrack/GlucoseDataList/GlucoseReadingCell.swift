//
//  GlucoseReadingCell.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/6/24.
//

import SwiftUI

struct GlucoseReadingCell: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var globalState: GlobalState

    @State private var viewModel = ViewModel()
    
    var reading: GTGlucoseMeasurement
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(reading.formattedMeasurement) \(reading.measurementUnit)")
            
            Text(reading.formattedMeasurementDate)
                .foregroundStyle(.secondary)
            
            Spacer()
                .frame(height: 20)
            
            Text(reading.userNotes)
                .foregroundStyle(.secondary)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button {
                viewModel.toggleShowEditBloodSugarScreen()
            } label: {
                Label("Edit", systemImage: "pencil")
                    .labelStyle(.iconOnly)
            }
            .tint(.blue)
            
            Button(role: .destructive) {
                viewModel.toggleIsDeleteRequested()
            } label: {
                Label("Delete", systemImage: "trash")
                    .labelStyle(.iconOnly)
            }
        }
        .confirmationDialog("Are you sure you want to delete this blood sugar reading?", isPresented: $viewModel.isDeleteRequested) {
            Button("Delete", role: .destructive){
                viewModel.delete(reading, context: context)
                // viewModel.id = UUID()
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleIsDeleteRequested)
        }
        .alert(isPresented: $viewModel.isShowingError, error: viewModel.error) { error in
            Text(error.failureReason!)
        } message: { error in
            Text(error.errorDescription!)
        }
        .sheet(isPresented: $viewModel.isShowingEditBloodSugarScreen) {
            viewModel.id = UUID()
        } content: {
            EditBloodSugarReadingScreen(reading: reading)
        }
    }
}
