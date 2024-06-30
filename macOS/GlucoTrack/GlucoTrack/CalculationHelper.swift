//
//  CalculationHelper.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/29/24.
//

import Foundation

class CalculationHelper {
    static func convert(_ value: Double, from: UnitOfMeasure, to: UnitOfMeasure) throws -> Double {
        guard from != to else {
            throw CalculationError.sameMeasurement
        }
        
        if from == .milligramsPerDecilitre && to == .millimolesPerLitre {
            return value / 18
        }
        
        return value * 18
    }
}
