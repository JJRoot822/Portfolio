//
//  MainVC.swift
//  DocuScan
//
//  Created by Joshua Root on 4/10/25.
//

import UIKit

class MainVC: UIViewController {
	var mainView: MainView!
	
	override func loadView() {
		super.loadView()
		
		self.mainView = MainView()
		self.view = mainView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureButtonActions()
	}
	
	private func configureButtonActions() {
		self.mainView.viewResultsButton.addTarget(self, action: #selector(showTextRecognitionResults), for: .touchUpInside)
		self.mainView.scanButton.addTarget(self, action: #selector(showDocumentScanner), for: .touchUpInside)
		self.mainView.clearResultsButton.addTarget(self, action: #selector(clearTextRecognitionResults), for: .touchUpInside)
	}
	
	@objc private func showTextRecognitionResults() {
		
	}
	
	@objc private func showDocumentScanner() {
		
	}
	
	@objc private func clearTextRecognitionResults() {
		
	}
}
