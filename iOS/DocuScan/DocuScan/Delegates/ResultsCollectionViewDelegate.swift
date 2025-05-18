//
//  ResultsCollectionViewDelegate.swift
//  DocuScan
//
//  Created by Joshua Root on 4/17/25.
//


class ResultsCollectionViewDelegate: NSObject, UICollectionViewDelegate {
	var results: [TextRecognitionResult]
	
	init(results: [TextRecognitionResult]) {
		self.results = results
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
}