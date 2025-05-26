//
//  VisionError.swift
//  DocuScan
//
//  Created by Joshua Root on 4/17/25.
//

import Foundation

enum VisionError: Error {
	case textRecognitionError
	
	var localizedDescription: String {
		switch self {
		case .textRecognitionError:
			return "The text recognition operation couldn't be completed."
		}
	}
}
