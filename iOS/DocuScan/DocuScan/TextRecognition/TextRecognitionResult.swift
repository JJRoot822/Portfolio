//
//  TextRecognitionResult.swift
//  DocuScan
//
//  Created by Joshua Root on 4/17/25.
//

import Vision
import UIKit

struct TextRecognitionResult: Hashable {
	var image: UIImage
	var pageNumber: Int
	var observations: [RecognizedTextObservation]

	func topCandidates() -> [RecognizedText] {
		var recognizedText = [RecognizedText]()
		
		for observation in observations {
			recognizedText.append(observation.topCandidates(1)[0])
		}
		
		return recognizedText
	}
	
	func recognizedTextBoundingBoxes() -> [CGRect] {
		return observations.map { observation in
			return observation.boundingBox.toImageCoordinates(image.size, origin: .upperLeft)
		}
	}
}
