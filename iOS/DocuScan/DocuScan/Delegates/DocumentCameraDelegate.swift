//
//  DocumentCameraDelegate.swift
//  DocuScan
//
//  Created by Joshua Root on 5/14/25.
//

import VisionKit

class DocumentCameraDelegate: NSObject, VNDocumentCameraViewControllerDelegate{
	var resultsVC: DocumentScanResultsVC
	
	init(resultsVC: DocumentScanResultsVC) {
		self.resultsVC = resultsVC
	}
	
	func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
		controller.dismiss(animated: !UIAccessibility.isReduceMotionEnabled)
	}
	
	func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
		print("Called")
		
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		
		appDelegate.documentScanResults.removeAll()
		
		for page in 0..<scan.pageCount {
			print("Converting page \(page + 1)")
			let item = RecognitionItem(pageNumber: page + 1, image: scan.imageOfPage(at: page))
			appDelegate.documentScanResults.append(item)
		}
		
		controller.dismiss(animated: !UIAccessibility.isReduceMotionEnabled)
		
		resultsVC.recognizeText(initialLoad: true)
	}
	
	func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: any Error) {
		let alert = UIAlertController(title: "Failed to Scan Document", message: error.localizedDescription, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default))
		controller.present(alert, animated: !UIAccessibility.isReduceMotionEnabled)
	}
}
