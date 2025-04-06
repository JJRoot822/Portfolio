//
//  DestinationSortOrder.swift
//  NomadTravel
//
//  Created by Joshua Root on 2/28/25.
//

import UIKit

enum DestinationSortOrder: String, CaseIterable {
    case nameAscending = "Name (Ascending)",
		 nameDescending = "Name (Descending)",
		 dateCreatedAscending = "Creation Date (Ascending)",
		 dateCreatedDescending = "Creation Date (Descending)",
		 modifiecationDateAscending = "Modification Date (Ascending)",
		 modificationDateDescending = "Modification Date (Descending)"
	
	static var allCases: [DestinationSortOrder] {
		return [ .nameAscending, .nameDescending, .dateCreatedAscending, .dateCreatedDescending, .modifiecationDateAscending, .modificationDateDescending ]
	}
	
	static func sortDescriptor(for order: DestinationSortOrder) -> SortDescriptor<Destination> {
		switch order {
		case .nameAscending:
			return SortDescriptor(\.name, order: .forward)
		case .nameDescending:
			return SortDescriptor(\.name, order: .reverse)
		case .dateCreatedAscending:
			return SortDescriptor(\.createdAt, order: .forward)
		case .dateCreatedDescending:
			return SortDescriptor(\.createdAt, order: .reverse)
		case .modifiecationDateAscending:
			return SortDescriptor(\.lastModifiedAt, order: .forward)
		case .modificationDateDescending:
			return SortDescriptor(\.lastModifiedAt, order: .reverse)
		
		}
	}
}
