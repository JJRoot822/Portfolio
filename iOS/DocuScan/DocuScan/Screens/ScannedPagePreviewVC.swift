//
//  ScannedPagePreviewVC.swift
//  DocuScan
//
//  Created by Joshua Root on 5/17/25.
//

import SwiftUI

class ScannedPagePreviewVC: UIViewController {
	var previewHostingController: UIHostingController<ScanPagePreviewView>!
	
	var result: TextRecognitionResult
	
	init(result: TextRecognitionResult) {
		self.result = result
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("Not supported")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Page \(result.pageNumber)"
		navigationController?.navigationBar.prefersLargeTitles = false
		configure()
	}
	
	private func configure() {
		configureUI()
		configureConstraints()
	}
	
	private func configureUI() {
		previewHostingController = UIHostingController(rootView: ScanPagePreviewView(result: result))
		addChild(previewHostingController)
		previewHostingController.didMove(toParent: self)
		previewHostingController.view.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(previewHostingController.view)
	}
	
	private func configureConstraints() {
		NSLayoutConstraint.activate([
			previewHostingController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			previewHostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			previewHostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			previewHostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

