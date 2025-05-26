//
//  VisionUtility.swift
//  DocuScan
//
//  Created by Joshua Root on 4/16/25.
//

import Vision

class VisionUtility {
	var accuracy: RecognizeTextRequest.RecognitionLevel
	var automaticallyDetectLanguage: Bool
	var useLanguageCorrection: Bool
	
	init(accuracy: RecognizeTextRequest.RecognitionLevel, automaticallyDetectLanguage: Bool, useLanguageCorrection: Bool) {
		self.accuracy = accuracy
		self.automaticallyDetectLanguage = automaticallyDetectLanguage
		self.useLanguageCorrection = useLanguageCorrection
	}
	
	func recognizeText(from items: [RecognitionItem]) async throws -> [TextRecognitionResult] {
		let results: [TextRecognitionResult]
		
		do {
			results = try await withThrowingTaskGroup(of: [TextRecognitionResult].self) { group in
				for item in items {
					group.addTask { [weak self] in
						guard let self = self else { return [] }
						
						let result = try await self.recognizeText(from: item)
						return [ result ]
					}
				}
				
				var allResults = [TextRecognitionResult]()
				
				for try await results in group {
					allResults.append(contentsOf: results)
				}
				
				return allResults.sorted { $0.pageNumber < $1.pageNumber }
			}
		} catch {
			throw VisionError.textRecognitionError
		}
		
		return results
	}
	
	func recognizeText(from item: RecognitionItem) async throws -> TextRecognitionResult {
		var request = RecognizeTextRequest()
		request.automaticallyDetectsLanguage = self.automaticallyDetectLanguage
		request.recognitionLevel = self.accuracy
		request.usesLanguageCorrection = self.useLanguageCorrection
		
		let observations: [RecognizedTextObservation]
		
		do {
			observations = try await request.perform(on: item.image.cgImage!)
		} catch {
			throw VisionError.textRecognitionError
		}
		
		return TextRecognitionResult(image: item.image, pageNumber: item.pageNumber, observations: observations)
	}
}
