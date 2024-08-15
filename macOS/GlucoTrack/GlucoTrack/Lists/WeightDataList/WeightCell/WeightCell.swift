//
//  WeightCell.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/13/24.
//

import SwiftUI

struct WeightCell: View {
    @Environment(\.managedObjectContext) var context
    @State private var viewModel = ViewModel()
    
    var weight: GTWeight
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(weight.formattedValue) \(weight.weightUnit)")
            
            Text(weight.formattedDateMeasured)
                .foregroundStyle(.secondary)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button {
                viewModel.toggleShowEditWeightScreen()
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
        .confirmationDialog("Are you sure you want to delete this weight log entry?", isPresented: $viewModel.isDeleteRequested) {
            Button("Delete", role: .destructive){
                viewModel.delete(weight, context: context)
                // viewModel.id = UUID()
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleIsDeleteRequested)
        }
        .alert(isPresented: $viewModel.isShowingError, error: viewModel.error) { error in
            Text(error.failureReason!)
        } message: { error in
            Text(error.errorDescription!)
        }
        .sheet(isPresented: $viewModel.isShowingEditWeightScreen) {
            viewModel.id = UUID()
        } content: {
            EditWeightScreen(weight: weight)
        }
    }
}
