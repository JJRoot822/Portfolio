//
//  DestinationValidator.swift
//  NomadTravel
//
//  Created by Joshua Root on 3/12/25.
//

import Foundation

class DestinationValidator {
	static func isValidName(_ name: String) -> Bool {
		return Validator.exists(name)
	}
	
	static func isValidLocation(_ location: String) -> Bool {
	return Validator.exists(location)
	}
	
	static func isValidCoordinates(latitude: String, longitude: String) -> Bool {
		if Validator.bothExist(first: latitude, second: longitude) {
			if !Validator.isDouble(latitude) && !Validator.isDouble(longitude) {
				return false
			} else {
				if !Validator.isDouble(latitude) && Validator.isDouble(longitude) {
					return false
				}
				
				if Validator.isDouble(latitude) && !Validator.isDouble(longitude) {
					return false
				}
			}
		} else {
			if Validator.exists(latitude) && !Validator.exists(longitude) {
				return false
			}
			
			if !Validator.exists(latitude) && Validator.exists(longitude) {
				return false
			}
		}
		
		return true
	}
	
	static func validate(name: String, location: String, latitude: String, longitude: String) -> String? {
		if isValidName(name) && isValidLocation(location) && isValidCoordinates(latitude: latitude, longitude: longitude) {
			return nil
		}
		
		return "Name and location must not be left blank. If you enter coordinates, both latitude and longitude must have a numeric value, otherwise they must be empty."
	}
}
