class ScanResultCell: UITableViewCell {
	static let reuseIdentifier: String = "scan_result_cell"
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder: NSCoder) {
		fatalError("Not Supported")
	}
	
	func set(result: TextRecognitionResult) {
		
	}
}

