struct ScanResultCellView: View {
	var result: TextRecognitionResult
	
	var body: some View {
		VStack {
			Image(uiImage: result.image)
				.resizable()
				.scaledToFit()
				.frame(width: 125, height: 125)
			
			Spcer()
			
			Text("Page \(result.pageNumber)")
		}
	}
}