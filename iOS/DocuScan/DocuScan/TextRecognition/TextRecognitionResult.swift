struct TextRecognitionResult {
	var image: UIImage
	var pageNumber: Int
	var observations: [RecognizedTextObservation]
	
	func recognizedTextBoundingBoxes() -> [CGRect] {
		return observations.map { observation in
			return observation.boundingBox.toImageCoordinates(image.size, origin: .upperLeft)
		}
	}
}

struct RecognitionItem {
	var pageNumber: Int
	var image: UIImage
}