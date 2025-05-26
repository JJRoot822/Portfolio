//
//  ResultsCollectionViewDataSource.swift
//  DocuScan
//
//  Created by Joshua Root on 5/12/25.
//

import UIKit

class ResultsCollectionViewDataSource: UICollectionViewDiffableDataSource<Section, TextRecognitionResult> {
	override init(collectionView: UICollectionView, cellProvider: @escaping CellProvider) {
		super.init(collectionView: collectionView, cellProvider: cellProvider)
	}
	
	func applySnapshot(results: [TextRecognitionResult], animatingDifferences: Bool = !UIAccessibility.isReduceMotionEnabled) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, TextRecognitionResult>()
		snapshot.appendSections([ .main ])
		snapshot.appendItems(results)
		
		apply(snapshot, animatingDifferences: animatingDifferences)
	}
	
	func update(results: [TextRecognitionResult], animateDifferences: Bool = !UIAccessibility.isReduceMotionEnabled) {
		
	}
}
