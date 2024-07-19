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
    
    @Binding var selectedRecord: GTGlucoseMeasurement.ID?
    
    init(selectedRecord: Binding<GTGlucoseMeasurement.ID?>, rangeStartDate: Date, rangeEndDate: Date, numberOfRecords: Int, searchTerm: String) {
        self._viewModel = State(wrappedValue: ViewModel())
        self._selectedRecord = selectedRecord
        
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
            Table(measurements, selection: $selectedRecord) {
                TableColumn("Glucose Level") { reading in
                    Text(reading.formattedMeasurement)
                        .foregroundStyle(
                            viewModel.getColorBy(value: reading.value, inRangeHighValue: inRangeHighValue, inRangeLowValue: inRangeLowValue, tooLowHighValue: tooLowHighValue, tooHighLowValue: tooHighLowValue)
                        )
                }
                
                TableColumn("Unit", value: \.measurementUnit)
                TableColumn("Date Measured", value: \.formattedMeasurementDate)
                TableColumn("Status") { reading in
                    if reading.value >= inRangeLowValue && reading.value <= inRangeHighValue {
                        Text("In Range")
                    } else if reading.value > tooHighLowValue && reading.value < inRangeLowValue {
                        Text("Below Range")
                    } else if reading.value > inRangeHighValue && reading.value < tooHighLowValue {
                        Text("Above Range")
                    } else if reading.value <= tooLowHighValue {
                        Text("Too Low")
                    } else {
                        Text("Too High")
                    }
                }
                TableColumn("Notes", value: \.userNotes)
            }
            
            HStack {
                Button {
                    globalState.showAddBloodSugarReading.toggle()
                } label: {
                    Label("add Reading", systemImage: "plus")
                        .labelStyle(.iconOnly)
                }
                
                Button {
                    viewModel.toggleIsDeleteRequested()
                } label: {
                    Label("Remove Reading", systemImage: "minus")
                        .labelStyle(.iconOnly)
                }
            }
        }
        .confirmationDialog("Are you sure you want to delete this measurement?", isPresented: $viewModel.isDeleteRequested) {
            Button("Delete", role: .destructive){
                if let selectedRecord = selectedRecord {
                    viewModel.delete(record: context.object(with: selectedRecord), context: context)
                }
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleIsDeleteRequested)
        }
        .alert(isPresented: $viewModel.isShowingError, error: viewModel.error) { error in
            Text(error.failureReason!)
        } message: { error in
            Text(error.errorDescription!)
        }
    }
}
