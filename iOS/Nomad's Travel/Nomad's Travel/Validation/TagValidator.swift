//
//  TagValidator.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/7/25.
//

import Foundation

class TagValidator {
	static func isValidTitle(_ title: String) -> Bool {
		return Validator.exists(title)
	}
	
	static func isValidColor(_ color: String) -> Bool {
		return Validator.exists(color)
	}
	
	static func isValidTag(title: String, color: String) -> Bool {
		return isValidTitle(title) && isValidColor(color)
	}
}
