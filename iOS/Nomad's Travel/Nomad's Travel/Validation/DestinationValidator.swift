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
	
	static func isValidZipCode(_ zipCode: String) -> Bool {
		return Validator.exists(zipCode) && Validator.isNumeric(zipCode) && Validator.isValidLength(string: zipCode, length: 5)
	}
	
	static func isValidCountry(_ country: String) -> Bool {
		return Validator.exists(country)
	}
	
	static func isValidCity(_ city: String) -> Bool {
		return Validator.exists(city)
	}
	
	static func isValidDestination(name: String, city: String, country: String, zipCode: String) -> Bool {
		return isValidName(name) &&
			   isValidCity(city) &&
			   isValidCountry(country) &&
			   isValidZipCode(zipCode)
	}
}
