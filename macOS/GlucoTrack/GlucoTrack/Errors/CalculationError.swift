//
//  CalculationError.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/29/24.
//

import Foundation

enum CalculationError: LocalizedError {
    case sameMeasurement
    
    var failureReason: String? {
        switch self {
        case .sameMeasurement:
            return "You cannot convert from the same unit that you want to convert to."
        }
    }
}
