//
//  Constants.swift
//  NomadTravel
//
//  Created by Joshua Root on 2/26/25.
//

import Foundation

class Constants {
	static let selectedTabKey = "selected_tab"

	static let noTagId = UUID()
	
	static let deleteDestinationErrorTitle = "Failed to Delete Destination"
	static let deleteDestinationErrorMessage = "Something went wrong when trying to delete the specified destination. Please try again later."
	
	static let updateDestinationVisitedStatusErrorTitle = "Failed to Update the Visited Status"
	static let updateDestinationVisitedStatusErrorMessage = "Something went wrong when trying to update the visited status of the specified destination. Please try again later."
	
	static let updateDestinationErrorTitle = "Failed to Update the Destination"
	static let updateDestinationErrorMessage = "Something went wrong when trying to update the specified destination. Please try again later."
	
	static let insertDestinationErrorTitle = "Failed to Create Destination"
	static let insertDestinationErrorMessage = "Something went wrong when trying to add a destination with the data you provided. Please try again later."
	
	static let destinationGeocodingErrorTitle = "Unable to Get Location Data"
	static let destinationGeocodingErrorMessage = "Something went wrong when trying to get the information necessary to display this destination on the map. Please try again later."
	
	
	static let insertTagErrorTitle = "Failed to Create Tag"
	static let insertTagErrorMessage = "Something went wrong when trying to add a new tag with the data you provided. Please try again later."

	static let updateTagErrorTitle = "Failed to Update Tag"
	static let updateTagErrorMessage = "Something went wrong when trying to update the specified tag. Please try again later."

	static let removeTagFromDestinationErrorTitle = "Failed to Remove Tag"
	static let removeTagFromDestinationErrorMessage = "Something went wrong when trying to remove the specified tag from the specified destination. Please try again later."
	
	static let deleteTagErrorTitle = "Failed to Delete Tag"
	static let deleteTagErrorMessage = "Something went wrong when trying to delete the specified tag. Please try again later."

	static let tagDestinationErrorTitle = "Couldn't Add Tag to Destination"
	static let tagDestinationErrorMessage = "Something went wrong when trying to add the specified tag to the specified destination. Please try again later."
	
static let states: [USState] = [
		USState(abbreviation: "AL", name: "Alabama"),
		USState(abbreviation: "AK", name: "Alaska"),
		USState(abbreviation: "AZ", name: "Arizona"),
		USState(abbreviation: "AR", name: "Arkansas"),
		USState(abbreviation: "CA", name: "California"),
		USState(abbreviation: "CO", name: "Colorado"),
		USState(abbreviation: "CT", name: "Connecticut"),
		USState(abbreviation: "DE", name: "Delaware"),
		USState(abbreviation: "FL", name: "Florida"),
		USState(abbreviation: "GA", name: "Georgia"),
		USState(abbreviation: "HI", name: "Hawaii"),
		USState(abbreviation: "ID", name: "Idaho"),
		USState(abbreviation: "IL", name: "Illinois"),
		USState(abbreviation: "IN", name: "Indiana"),
		USState(abbreviation: "IA", name: "Iowa"),
		USState(abbreviation: "KS", name: "Kansas"),
		USState(abbreviation: "KY", name: "Kentucky"),
		USState(abbreviation: "LA", name: "Louisiana"),
		USState(abbreviation: "ME", name: "Maine"),
		USState(abbreviation: "MD", name: "Maryland"),
		USState(abbreviation: "MA", name: "Massachusetts"),
		USState(abbreviation: "MI", name: "Michigan"),
		USState(abbreviation: "MN", name: "Minnesota"),
		USState(abbreviation: "MS", name: "Mississippi"),
		USState(abbreviation: "MO", name: "Missouri"),
		USState(abbreviation: "MT", name: "Montana"),
		USState(abbreviation: "NE", name: "Nebraska"),
		USState(abbreviation: "NV", name: "Nevada"),
		USState(abbreviation: "NH", name: "New Hampshire"),
		USState(abbreviation: "NJ", name: "New Jersey"),
		USState(abbreviation: "NM", name: "New Mexico"),
		USState(abbreviation: "NY", name: "New York"),
		USState(abbreviation: "NC", name: "North Carolina"),
		USState(abbreviation: "ND", name: "North Dakota"),
		USState(abbreviation: "OH", name: "Ohio"),
		USState(abbreviation: "OK", name: "Oklahoma"),
		USState(abbreviation: "OR", name: "Oregon"),
		USState(abbreviation: "PA", name: "Pennsylvania"),
		USState(abbreviation: "RI", name: "Rhode Island"),
		USState(abbreviation: "SC", name: "South Carolina"),
		USState(abbreviation: "SD", name: "South Dakota"),
		USState(abbreviation: "TN", name: "Tennessee"),
		USState(abbreviation: "TX", name: "Texas"),
		USState(abbreviation: "UT", name: "Utah"),
		USState(abbreviation: "VT", name: "Vermont"),
		USState(abbreviation: "VA", name: "Virginia"),
		USState(abbreviation: "WA", name: "Washington"),
		USState(abbreviation: "WV", name: "West Virginia"),
		USState(abbreviation: "WI", name: "Wisconsin"),
		USState(abbreviation: "WY", name: "Wyoming")
	]
}
