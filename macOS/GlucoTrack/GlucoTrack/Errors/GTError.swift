//
//  GTError.swift
//  GlucoTrack
//
//  Created by Joshua Root on 7/5/24.
//

import Foundation

enum GTError: LocalizedError, Identifiable {
    case insertGlucoseError, updateGlucoseError, deleteGlucoseError, deleteGlucoseBatchError,
         insertMedicationError, updateMedicationError, deleteMedicationError, deleteMedicationBatchError,
         insertMedRecordError, updateMedRecordError, deleteMedRecordError, deleteMedRecordBatchError,
         insertWeightError, updateWeightError, deleteWeightError, deleteWeightBatchError,
         saveError
    
    var id: Int {
        switch self {
        case .insertGlucoseError:
            return 1
        case .updateGlucoseError:
            return 2
        case .deleteGlucoseError:
            return 3
        case .deleteGlucoseBatchError:
            return 4
        case .insertMedicationError:
            return 5
        case .updateMedicationError:
            return 6
        case .deleteMedicationError:
            return 7
        case .deleteMedicationBatchError:
            return 8
        case .insertMedRecordError:
            return 9
        case .updateMedRecordError:
            return 10
        case .deleteMedRecordError:
            return 11
        case .deleteMedRecordBatchError:
            return 12
        case .insertWeightError:
            return 13
        case .updateWeightError:
            return 14
        case .deleteWeightError:
            return 15
        case .deleteWeightBatchError:
            return 16
        case .saveError:
            return 17
        }
    }
    
    var failureReason: String? {
        switch self {
        case .insertGlucoseError:
            return "Something went wrong when trying to create blood sugar reading data. Please try again later."
        case .updateGlucoseError:
            return "Something went wrong when trying to update the blood sugar reading data. Please try again later."
        case .deleteGlucoseError:
            return "Something went wrong when trying to remove the selected blood sugar reading. Please try again later."
        case .deleteGlucoseBatchError:
            return "Something went wrong when trying to remove the selected blood sugar readings. Either try one at a time, or try again later."
        case .insertMedicationError:
            return "Something went wrong when trying to create medication data. Please try again later."
        case .updateMedicationError:
            return "Something went wrong when trying to update the medication data. Please try again later."
        case .deleteMedicationError:
            return "Something went wrong when trying to remove the selected medication data. Please try again later."
        case .deleteMedicationBatchError:
            return "Something went wrong when trying to remove the selected medication data. Either do one at a time, or try again later."
        case .insertMedRecordError:
            return"Something went wrong when trying to create a new medication record. Please try again."
        case .updateMedRecordError:
            return "Something went wrong when trying to update the medication record data. Please try again later."
        case .deleteMedRecordError:
            return "Something went wrong when trying to remove the selected medication record data. Please try again later."
        case .deleteMedRecordBatchError:
            return"Something went wrong when trying to remove the selected medication record data. Either try one at a time, or try again later."
        case .insertWeightError:
            return"Something went wrong when trying to create weight data. Please try again later."
        case .updateWeightError:
            return "Something went wrong when trying to update the selected weight data. Please try again later."
        case .deleteWeightError:
            return"Something went wrong when trying to remove the weight data. Please try again later."
        case .deleteWeightBatchError:
            return"Something went wrong when trying to remove the weight data you selected. Either select one at a time or try again later."
        case .saveError:
            return "Failed to save the changes you made. Please try again later."
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .insertGlucoseError:
            return "Failed to Create Blood Sugar Reading Data"
        case .updateGlucoseError:
            return "Failed to Update Blood Sugar Reading Data"
        case .deleteGlucoseError:
            return "Failed to Remove Blood Sugar Reading Data"
        case .deleteGlucoseBatchError:
            return "Failed to Remove Multiple Blood Sugar Reading Data Entries"
        case .insertMedicationError:
            return"Failed to Create Medication Data"
        case .updateMedicationError:
            return "Failed to Update Medication Data"
        case .deleteMedicationError:
            return "Failed to Remove Medication Data"
        case .deleteMedicationBatchError:
            return "Failed to Remove Multiple Medication Data Entries"
        case .insertMedRecordError:
            return"Failed to Create Medication Record Data"
        case .updateMedRecordError:
            return"Failed to Update Medication Record Data"
        case .deleteMedRecordError:
            return"Failed to Remove Medication Record Data"
        case .deleteMedRecordBatchError:
            return "Failed to Remove Multiple Medication Record Data Entries"
        case .insertWeightError:
            return"Failed to Create Weight Data"
        case .updateWeightError:
            return"Failed to Update Weight Data"
        case .deleteWeightError:
            return "Failed to Remove Weight Data"
        case .deleteWeightBatchError:
            return "Failed to Remove Multiple Weight Data Entries"
        case .saveError:
            return "Failed to Save Changes"
        }
    }
}
