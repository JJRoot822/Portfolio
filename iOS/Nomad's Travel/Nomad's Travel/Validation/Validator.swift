//
//  Validator.swift
//  NomadTravel
//
//  Created by Joshua Root on 3/12/25.
//

import Foundation

class Validator {
	static func exists(_ string: String) -> Bool {
		return !string.isEmpty
	}
	
	static func isDouble(_ string: String) -> Bool {
		return Double(string) != nil
	}
	
	static func bothExist(first: String, second: String) -> Bool {
		return exists(first) && exists(second)
	}
}
