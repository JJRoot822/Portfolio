//
//  Constants.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/31/24.
//

import Foundation
class Constants {
    static let inRangeLowerBoundKey = "gt-in-range-lower-bound"
    static let inRangeUpperBoundKey = "gt-in-range-upper-bound"
    static let tooLowUpperBoundKey = "gt-too-low-upper-bound"
    static let tooHighLowerBoundKey = "gt-too-high-lower-bound"
    static let bloodGlucoseUnitKey = "gt-bgm-unit"
    static let weightUnitKey = "gt-weight-unit"
    static let bloodGlucoseDisplayModeKey = "gt-blood-sugar-display-mode"
    
    static let invalidRangesErrorMessage = "The upper limit of Too Low readings must be lower than the lower limit of In Range readings.\n\nThe lower limit of In Range readings must be between the upper limit of Too Low and the upper limit of In Range.\n\nThe upper limit of In Range readings must be lower than the lower limit of Too High readings."
}
