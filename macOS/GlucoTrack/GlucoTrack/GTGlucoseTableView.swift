//
//  GTTableView.swift
//  GlucoTrack
//
//  Created by Joshua Root on 7/16/24.
//

import SwiftUI

struct GTGlucoseTableView: NSViewRepresentable {
    @Binding var selection: [GTGlucoseMeasurement]
    
    var data: [GTGlucoseMeasurement]
    
    private var table = NSTableView()
    
    class Coordinator: NSObject, NSTableViewDelegate, NSTableViewDataSource {
        private var parent: GTGlucoseTableView
        private var data: [GTGlucoseMeasurement]
        
        init(parent: GTGlucoseTableView, data: [GTGlucoseMeasurement]) {
            self.parent = parent
            self.data = data
        }
        
        func numberOfRows(in tableView: NSTableView) -> Int {
            return data.count
        }
        
        func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
            return true
        }
        
        func tableViewSelectionDidChange(_ notification: Notification) {
            parent.selection = parent.table.selectedRowIndexes.map {index in
                data[index]
            }
        }
        
        func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
            var cellView: NSTableCellView?
            
            if let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView {
                cellView = cell
            } else {
                let cell = createCell()
                cellView = cell
            }
            
            switch tableColumn!.identifier {
            case NSUserInterfaceItemIdentifier("value_column"):
                cellView!.textField!.stringValue = data[row].formattedMeasurement
            case NSUserInterfaceItemIdentifier("unit_column"):
                cellView!.textField!.stringValue = data[row].measurementUnit
            case NSUserInterfaceItemIdentifier("date_column"):
                cellView!.textField!.stringValue = data[row].formattedMeasurementDate
            case NSUserInterfaceItemIdentifier("notes_column"):
                cellView!.textField!.stringValue = data[row].userNotes
            default:
                cellView!.textField!.stringValue = ""
            }
            
            return cellView
        }
        
        private func createCell() -> NSTableCellView {
            let cell = NSTableCellView()
            let textField = NSTextField()
            
            textField.drawsBackground = false
            textField.isSelectable = false
            textField.isEditable = false
            textField.isBezeled = false
            textField.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview(textField)
            
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: cell.topAnchor),
                textField.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
                textField.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
                textField.leadingAnchor.constraint(equalTo: cell.leadingAnchor)
            ])
            
            cell.textField = textField
            
            return cell
        }
    }
    
    func makeNSView(context: Context) -> NSTableView {
        let table = self.table
        table.allowsColumnResizing = true
        table.allowsEmptySelection = true
        table.allowsMultipleSelection = true
        
        for column in getColumns() {
            table.addTableColumn(column)
        }
        
        table.delegate = context.coordinator
        table.dataSource = context.coordinator
        
        return table
    }
    
    private func getColumns() -> [NSTableColumn] {
        let valueColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("value_column"))
        let unitColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("unit_column"))
        let dateColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("date_column"))
        let notesColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("notes_column"))
        
        valueColumn.title = "Glucose Level"
        unitColumn.title = "Unit of Measure"
        dateColumn.title = "Date Reading Taken "
        notesColumn.title = "Notes"
        
        return [ valueColumn, unitColumn, dateColumn, notesColumn ]
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, data: data)
    }
    
    func updateNSView(_ nsView: NSTableView, context: Context) {}
}
