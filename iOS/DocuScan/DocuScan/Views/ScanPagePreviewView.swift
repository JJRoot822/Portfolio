struct ScanPagePreviewView: View {
	var result: TextRecognitionResult
	
	var body: some View {
		TabView {
			PagePreviewImage(image: result.image)
			RecognizedTextView(observations: result.topCandidates())
		}
		.tabViewStyle(.page)
	}
}
