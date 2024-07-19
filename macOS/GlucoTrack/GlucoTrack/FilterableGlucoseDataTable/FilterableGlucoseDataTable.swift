//
//  FilterableTable.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/27/24.
//

import SwiftUI
import CoreData

struct FilterableGlucoseDataTable: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var globalState: GlobalState

    @FetchRequest var measurements: FetchedResults<GTGlucoseMeasurement>

    @AppStorage("gt-in-range-lower-bound") var inRangeLowValue: Double = 70.0
    @AppStorage("gt-in-range-upper-bound") var inRangeHighValue: Double = 120.0
    @AppStorage("gt-too-low-upper-bound") var tooLowHighValue: Double = 69.9
    @AppStorage("gt-too-high-lower-bound") var tooHighLowValue: Double = 160.0

    @State private var viewModel: ViewModel
    
    @Binding var selection: [GTGlucoseMeasurement]
    
    init(selection: Binding<[GTGlucoseMeasurement]>, rangeStartDate: Date, rangeEndDate: Date, numberOfRecords: Int, searchTerm: String) {
        self._viewModel = State(wrappedValue: ViewModel())
        self._selection = selection
        
        let startDate = rangeStartDate as NSDate
        let endDate = rangeEndDate as NSDate
        
        let predicate1 = NSPredicate(format: "%K >= %@ && %K <= %@", "dateMeasured", startDate, "dateMeasured", endDate)
        let predicate2 = NSPredicate(format: "notes contains %@", searchTerm)
        let fetchRequest: NSFetchRequest<GTGlucoseMeasurement> = GTGlucoseMeasurement.fetchRequest()
        fetchRequest.sortDescriptors = [ NSSortDescriptor(keyPath: \GTGlucoseMeasurement.dateMeasured, ascending: true) ]
        fetchRequest.fetchLimit = numberOfRecords
        fetchRequest.predicate = searchTerm.isEmpty ? predicate1 : NSCompoundPredicate(orPredicateWithSubpredicates: [ predicate1, predicate2 ])
        
        self._measurements = FetchRequest<GTGlucoseMeasurement>(fetchRequest: fetchRequest, animation: .default)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            GTGlucoseTableView(selection: $selection, data: measurements)
                .id(viewModel.id)
            
            HStack(spacing: 0) {
                Spacer()
                
                Button {
                    globalState.showAddBloodSugarReading.toggle()
                } label: {
                    Label("add Reading", systemImage: "plus")
                        .labelStyle(.iconOnly)
                }
                .buttonStyle(.borderless)
                
                
                Button {
                    viewModel.toggleIsDeleteRequested()
                } label: {
                    Label("Delete", systemImage: "minus")
                        .labelStyle(.iconOnly)
                }
                .buttonStyle(.borderless)
                
                Button("Edit", action: viewModel.toggleShowEditBloodSugarScreen)
            }
            .buttonStyle(.borderless)
        }
        .confirmationDialog("Are you sure you want to delete all selected blood sugar readings?", isPresented: $viewModel.isDeleteRequested) {
            Button("Delete", role: .destructive){
                viewModel.delete(selection, context: context)
                viewModel.id = UUID()
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
            EditBloodSugarReadingScreen(reading: measurements.first!)
        }
    }
}
