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
	
	static func isNumeric(_ string: String) -> Bool {
		for character in string {
			if !character.isNumber {
				return false
			}
		}
		
		return true
	}
	
	static func isValidLength(string: String, length: Int) -> Bool {
		return string.count == length
	}
}
