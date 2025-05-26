//
//  ResultsCollectionViewDelegate.swift
//  DocuScan
//
//  Created by Joshua Root on 4/17/25.
//

import UIKit

class ResultsCollectionViewDelegate: NSObject, UICollectionViewDelegate {
	var results: [TextRecognitionResult]
	var controller: DocumentScanResultsVC!
	
	init(results: [TextRecognitionResult]) {
		self.results = results
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let parentController = collectionView.parentViewController as? DocumentScanResultsVC else { return }
		
		parentController.openPreview(for: results[indexPath.item])
	}
}
