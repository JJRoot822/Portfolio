//
//  GTError.swift
//  GlucoTrack
//
//  Created by Joshua Root on 7/5/24.
//

import Foundation

enum GTError: LocalizedError, Identifiable {
    case insertGlucoseError, updateGlucoseError, deleteGlucoseError,
         insertMedicationError, updateMedicationError, deleteMedicationError,
         insertMedRecordError, updateMedRecordError, deleteMedRecordError,
         insertWeightError, updateWeightError, deleteWeightError,
         insertReminderError, updateReminderError, deleteReminderError,
         saveError, invalidMedicationEntryError, notAuthorizedError
    
    var id: Int {
        switch self {
        case .insertGlucoseError:
            return 1
        case .updateGlucoseError:
            return 2
        case .deleteGlucoseError:
            return 3
        case .insertMedicationError:
            return 4
        case .updateMedicationError:
            return 5
        case .deleteMedicationError:
            return 6
        case .insertMedRecordError:
            return 7
        case .updateMedRecordError:
            return 8
        case .deleteMedRecordError:
            return 9
        case .insertWeightError:
            return 10
        case .updateWeightError:
            return 11
        case .deleteWeightError:
            return 12
        case .insertReminderError:
            return 13
        case .updateReminderError:
            return 14
        case .deleteReminderError:
            return 15
        case .saveError:
            return 16
        case .invalidMedicationEntryError:
            return 17
        case .notAuthorizedError:
            return 18
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
        case .insertMedicationError:
            return "Something went wrong when trying to create medication data. Please try again later."
        case .updateMedicationError:
            return "Something went wrong when trying to update the medication data. Please try again later."
        case .deleteMedicationError:
            return "Something went wrong when trying to remove the selected medication data. Please try again later."
        case .insertMedRecordError:
            return"Something went wrong when trying to create a new medication record. Please try again."
        case .updateMedRecordError:
            return "Something went wrong when trying to update the medication record data. Please try again later."
        case .deleteMedRecordError:
            return "Something went wrong when trying to remove the selected medication record data. Please try again later."
        case .insertWeightError:
            return"Something went wrong when trying to create weight data. Please try again later."
        case .updateWeightError:
            return "Something went wrong when trying to update the selected weight data. Please try again later."
        case .deleteWeightError:
            return"Something went wrong when trying to remove the weight data. Please try again later."
        case .insertReminderError:
            return "Something went wrong when trying to create a reminder. Please try again later."
        case .updateReminderError:
            return "Something went wrong when tring to update the reminder. Please try again later."
        case .deleteReminderError:
            return "Something went wrong when trying to remove the reminder. Please try again later."
        case .saveError:
            return "Failed to save the changes you made. Please try again later."
        case .invalidMedicationEntryError:
            return "You must specify a medication to associate this record with."
        case .notAuthorizedError:
            return "You have not authorized GlucoTrack to send you notifications."
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
        case .insertMedicationError:
            return"Failed to Create Medication Data"
        case .updateMedicationError:
            return "Failed to Update Medication Data"
        case .deleteMedicationError:
            return "Failed to Remove Medication Data"
        case .insertMedRecordError:
            return"Failed to Create Medication Record Data"
        case .updateMedRecordError:
            return"Failed to Update Medication Record Data"
        case .deleteMedRecordError:
            return"Failed to Remove Medication Record Data"
        case .insertWeightError:
            return"Failed to Create Weight Data"
        case .updateWeightError:
            return"Failed to Update Weight Data"
        case .deleteWeightError:
            return "Failed to Remove Weight Data"
        case .insertReminderError:
            return "Failed to Create Reminder"
        case .updateReminderError:
            return "Failed to Update Reminder"
        case .deleteReminderError:
            return "Failed to Remove Reminder"
        case .saveError:
            return "Failed to Save Changes"
        case .invalidMedicationEntryError:
            return "Invalid Entry"
        case .notAuthorizedError:
            return "Notifications Not Authorized"
        }
    }
}
