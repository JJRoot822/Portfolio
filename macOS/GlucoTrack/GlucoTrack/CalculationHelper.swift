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
    
    static func convertPoundsToKilograms(_ value: Double) -> Double {
        return 0.45 * value
    }
    
    static func convertPoundsToStone(_ value: Double) -> Double {
        return 0.071 * value
    }
    
    static func convertStoneToPounds(_ value: Double) -> Double {
        return 14 * value
    }
    
    static func convertStoneToKilogram(_ Value: Double) -> Double {
        return 6.35 * Value
    }
    
    static func convertKilogramToPound(_ value: Double) -> Double {
        return 2.2 * value
    }
    
    static func convertKilogramToStone(_ value: Double) -> Double {
        return 0.16 * value
    }
    
    static func convert(from: Double, unit: WeightUnit, to: WeightUnit) -> Double {
        switch unit {
        case .pounds:
            switch to {
         case .kilograms:
                return convertPoundsToKilograms(from)
            case .stone:
                return convertPoundsToStone(from)
            default:
                return 0
            }
        case .kilograms:
            switch to {
            case .pounds:
                return convertKilogramToPound(from)
            case .stone:
                return convertKilogramToStone(from)
            default:
                return 0
            }
        case .stone:
            switch to {
            case .pounds:
                return convertStoneToPounds(from)
            case .kilograms:
                return convertStoneToKilogram(from)
            default:
                return 0
            }
        }
    }
}
