//
//  DocumentScanResultsVC.swift
//  DocuScan
//
//  Created by Joshua Root on 5/12/25.
//

import UIKit
import VisionKit

class DocumentScanResultsVC: UICollectionViewController {
	let appDelegate: AppDelegate
	
	var resultsDelegate: ResultsCollectionViewDelegate
	var resultsDataSource: ResultsCollectionViewDataSource!
	var docScannerDelegate: DocumentCameraDelegate!
	var layout: UICollectionViewFlowLayout
	var scanButton: UIBarButtonItem!
	
	var results: [TextRecognitionResult]
	
	init() {
		self.appDelegate = UIApplication.shared.delegate as! AppDelegate
		self.resultsDelegate = ResultsCollectionViewDelegate(results: [])
		self.results = [TextRecognitionResult]()
		
		self.layout = UICollectionViewFlowLayout()
		self.layout.itemSize = CGSize(width: 150, height: 250)
		self.layout.minimumLineSpacing = 20
		self.layout.minimumInteritemSpacing = 20
		
		super.init(collectionViewLayout: self.layout)
	}
	
	required init?(coder: NSCoder) {
		fatalError("Not supported")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "DocuScan"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		configure()
	}
	
	private func configure() {
		self.docScannerDelegate = DocumentCameraDelegate(resultsVC: self)
		
		self.collectionView.register(ScanResultCell.self, forCellWithReuseIdentifier: ScanResultCell.reuseIdentifier)
		
		self.resultsDataSource = ResultsCollectionViewDataSource(collectionView: collectionView) { collectionView, indexPath, result -> ScanResultCell? in
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScanResultCell.reuseIdentifier, for: indexPath) as? ScanResultCell else {
				return nil
			}
			
			cell.set(result: result)
			
			return cell
		}
		
		self.collectionView.delegate = resultsDelegate
		self.collectionView.dataSource = resultsDataSource
		
		self.resultsDataSource.applySnapshot(results: [])
		
		self.scanButton = UIBarButtonItem(title: "Scan Document", image: UIImage(systemName: "camera"), target: self, action: #selector(scanDocTapped))
		navigationItem.rightBarButtonItem = scanButton
	
		self.collectionView.refreshControl = UIRefreshControl()
		self.collectionView.refreshControl?.tintColor = .systemTeal
		self.collectionView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
	}
	
	func recognizeText(initialLoad: Bool) {
		Task {
			print("Called")
			
			let visionUtility = VisionUtility(accuracy: .accurate, automaticallyDetectLanguage: true, useLanguageCorrection: true)
			
			do {
				let results = try await visionUtility.recognizeText(from: appDelegate.documentScanResults)
				
				if !initialLoad {
					self.collectionView.refreshControl?.endRefreshing()
				}
				
				self.resultsDelegate.results = results
				self.resultsDataSource.applySnapshot(results: results)
			} catch {
				let alert = UIAlertController(title: "Failed to Recognize Text", message: error.localizedDescription, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default))
				present(alert, animated: !UIAccessibility.isReduceMotionEnabled)
			}
		}
	}

	func openPreview(for result: TextRecognitionResult) {
		let previewVC = ScannedPagePreviewVC(result: result)
		navigationController?.pushViewController(previewVC, animated: !UIAccessibility.isReduceMotionEnabled)
	}
	
	@objc private func refresh() {
		recognizeText(initialLoad: false)
	}
	
	@objc private func scanDocTapped() {
		let docScanner = VNDocumentCameraViewController()
		
		docScanner.delegate = docScannerDelegate
		
		present(docScanner, animated: !UIAccessibility.isReduceMotionEnabled)
	}
}

