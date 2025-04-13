//
//  MainView.swift
//  DocuScan
//
//  Created by Joshua Root on 4/10/25.
//

import UIKit

class MainView: UIView {
	var scanButton: UIButton!
	var viewResultsButton: UIButton!
	var clearResultsButton: UIButton!
	
	init() {
		super.init(frame: .zero)
		
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("Not supported")
	}
	
	private func configureScanButton() {
		var configuration = UIButton.Configuration.borderedProminent()
		configuration.image = UIImage(systemName: "camera.fill")
		configuration.baseBackgroundColor = .systemTeal
		configuration.baseForegroundColor = .white
		configuration.buttonSize = .large
		configuration.cornerStyle = .large
		
		scanButton = UIButton(configuration: configuration)
		scanButton.accessibilityLabel = "Scan Document"
		scanButton.translatesAutoresizingMaskIntoConstraints = false
		addSubview(scanButton)
	}
	
	private func configureViewResultsButton() {
		var configuration = UIButton.Configuration.bordered()
		configuration.title = "View Results"
		configuration.baseBackgroundColor = .systemTeal
		configuration.baseForegroundColor = .systemTeal
		configuration.cornerStyle = .medium
		
		viewResultsButton = UIButton(configuration: configuration)
		viewResultsButton.isEnabled = false
		viewResultsButton.translatesAutoresizingMaskIntoConstraints = false
		addSubview(viewResultsButton)
	}
	
	private func configureClearResultsButton() {
		var configuration = UIButton.Configuration.bordered()
		configuration.title = "Clear Results"
		configuration.baseBackgroundColor = .systemTeal
		configuration.baseForegroundColor = .systemTeal
		configuration.cornerStyle = .medium
		
		clearResultsButton = UIButton(configuration: configuration)
		clearResultsButton.isEnabled = false
		clearResultsButton.translatesAutoresizingMaskIntoConstraints = false
		addSubview(clearResultsButton)
	}
	
	private func configureConstraints() {
		scanButton.pinToCenter(of: self, useSafeAreaLayoutGuide: true)
		scanButton.pinSize(width: 175, height: 175)
		viewResultsButton.pinToBottomLeading(of: self, leadingPadding: 25, bottomPadding: -25, useSafeAreaLayoutGuide: true)
		viewResultsButton.pinTrailingToCenterX(of: self, padding: -10, useSafeAreaLayoutGuide: true)
		viewResultsButton.pinHeight(height: 50)
		clearResultsButton.pinToBottomTrailing(of: self, trailingPadding: -25, bottomPadding: -25, useSafeAreaLayoutGuide: true)
		clearResultsButton.pinLeadingToCenterX(of: self, padding: 10, useSafeAreaLayoutGuide: true)
		clearResultsButton.pinHeight(height: 50)
	}
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		
		configureScanButton()
		configureViewResultsButton()
		configureClearResultsButton()
		configureConstraints()
	}
}
