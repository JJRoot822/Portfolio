//
//  ScanResultCell.swift
//  DocuScan
//
//  Created by Joshua Root on 4/17/25.
//

import UIKit
import SwiftUI

class ScanResultCell: UICollectionViewCell {
	static let reuseIdentifier: String = "scan_result_cell"
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		fatalError("Not Supported")
	}
	
	func set(result: TextRecognitionResult) {
		contentConfiguration = UIHostingConfiguration { ScanResultCellView(result: result) }
	}
}



