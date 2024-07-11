//
//  DataService.swift
//  GlucoTrack
//
//  Created by Joshua Root on 7/5/24.
//

import CoreData

class DataService {
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveChanges() throws {
        do {
            try context.save()
        } catch {
            throw GTError.saveError
        }
    }
    
    func addReading(level: Double, unit: String, dateMeasured: Date, notes: String) throws {
        let bloodSugarLevel = GTGlucoseMeasurement(context: context)
        bloodSugarLevel.id = UUID()
        bloodSugarLevel.value = level
        bloodSugarLevel.unit = unit
        bloodSugarLevel.notes = notes
        bloodSugarLevel.dateMeasured = dateMeasured
        
        do {
            try saveChanges()
        } catch {
            rollbackUnsavedChanges()
            
            throw GTError.insertGlucoseError
        }
    }
    
    func modifyReading(oldReading: GTGlucoseMeasurement, level: Double, unit: String, dateMeasured: Date, notes: String) throws {
        oldReading.value = level
        oldReading.unit = unit
        oldReading.notes = notes
        oldReading.dateMeasured = dateMeasured
        
        do {
            try saveChanges()
        } catch {
            rollbackUnsavedChanges()
            
            throw GTError.updateGlucoseError
        }
    }
    
    func addMedication(name: String, doseValue: Float, doseUnit: String, datePrescribed: Date, notes: String) throws {
        let medication = GTMedication(context: context)
        medication.id = UUID()
        medication.name = name
        medication.doseValue = doseValue
        medication.doseUnit = doseUnit
        medication.notes = notes
        medication.datePrescribed = datePrescribed
        
        do {
            try saveChanges()
        } catch {
            rollbackUnsavedChanges()
            
            throw GTError.insertMedicationError
        }
    }
    
    func modifyMedication(oldMedication: GTMedication, name: String, doseValue: Float, doseUnit: String, datePrescribed: Date, notes: String) throws {
        oldMedication.name = name
        oldMedication.doseValue = doseValue
        oldMedication.doseUnit = doseUnit
        oldMedication.notes = notes
        oldMedication.datePrescribed = datePrescribed
        
        do {
            try saveChanges()
        } catch {
            rollbackUnsavedChanges()
            
            throw GTError.updateMedicationError
        }
    }
    
    func addMedicationRecord(doseAmountTaken: Float, doseUnit: String, notes: String, medication: GTMedication) throws {
        let record = GTMedicationRecord(context: context)
        record.id = UUID()
        record.doseAmountTaken = doseAmountTaken
        record.unit = doseUnit
        record.notes = notes
        record.medication = medication
        
        do {
            try saveChanges()
        } catch {
            rollbackUnsavedChanges()
            
            throw GTError.insertMedRecordError
        }
    }
    
    func modifyMedicationRecord(oldRecord: GTMedicationRecord, doseAmountTaken: Float, doseUnit: String, notes: String, medication: GTMedication) throws {
        oldRecord.doseAmountTaken = doseAmountTaken
        oldRecord.unit = doseUnit
        oldRecord.notes = notes
        oldRecord.medication = medication
        
        do {
            try saveChanges()
        } catch {
            rollbackUnsavedChanges()
            
            throw GTError.updateMedRecordError
        }
    }
    
    func insertWeight(value: Float, unit: String, dateWeighed: Date) throws {
        let weight = GTWeight(context: context)
        weight.id = UUID()
        weight.value = value
        weight.unit = unit
        weight.dateWeighed = dateWeighed
        
        do {
            try saveChanges()
        } catch {
            rollbackUnsavedChanges()
            
            throw GTError.insertWeightError
        }
    }
    
    func modifyWeight(oldWeight: GTWeight, value: Float, unit: String, dateWeighed: Date) throws {
        oldWeight.value = value
        oldWeight.unit = unit
        oldWeight.dateWeighed = dateWeighed
        
        do {
            try saveChanges()
        } catch {
            rollbackUnsavedChanges()
            
            throw GTError.updateWeightError
        }
    }
    
    private func delete<T: NSManagedObject>(_ object: T) {
        context.delete(object)
    }
    
    private func rollbackUnsavedChanges() {
        if context.hasChanges {
            context.rollback()
        }
    }
    
    func delete(measurement: GTGlucoseMeasurement) throws {
        delete(measurement)
        
        do {
            try saveChanges()
        } catch {
            rollbackUnsavedChanges()
            
            throw GTError.deleteGlucoseError
        }
    }
    
    func delete(measurements: [GTGlucoseMeasurement]) throws {
        for measurement in measurements {
            delete(measurement)
        }
        
        do {
            try saveChanges()
        } catch {
            rollbackUnsavedChanges()
            
            throw GTError.deleteGlucoseBatchError
        }
    }
    
    func delete(medication: GTMedication) throws {
        delete(medication)
        
        do {
            try saveChanges()
        } catch {
            rollbackUnsavedChanges()
            
            throw GTError.deleteGlucoseError
        }
    }
    
    func delete(medications: [GTMedication]) throws {
        for medication in medications {
            delete(medication)
        }
        
        do {
            try saveChanges()
        } catch {
            throw GTError.deleteMedicationBatchError
        }
    }
    
    func delete(record: GTMedicationRecord) throws {
        delete(record)
        
        do {
            try saveChanges()
        } catch {
            rollbackUnsavedChanges()
            
            throw GTError.deleteMedRecordError
        }
    }
    
    func delete(records: [GTMedicationRecord]) throws {
        for record in records {
            delete(record)
        }
        
        do {
            try saveChanges()
        } catch {
            rollbackUnsavedChanges()
            
            throw GTError.deleteMedRecordBatchError
        }
    }
    
    func delete(weight: GTWeight) throws {
        delete(weight)
        
        do {
            try saveChanges()
        } catch {
            rollbackUnsavedChanges()
            
            throw GTError.deleteWeightError
        }
    }
    
    func delete(weights: [GTWeight]) throws {
        for weight in weights {
            delete(weight)
        }
        
        do {
            try saveChanges()
        } catch {
            throw GTError.deleteWeightBatchError
        }
    }
}
