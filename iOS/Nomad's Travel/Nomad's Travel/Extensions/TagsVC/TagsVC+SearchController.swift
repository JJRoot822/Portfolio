//
//  TagsVC+SearchController.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/19/25.
//

import UIKit

extension TagsVC: UISearchResultsUpdating {
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a Tag"
        searchController.isActive = true
        searchController.searchBar.searchBarStyle = .default
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        reloadTask?.cancel()
        
        reloadTask = Task { @MainActor in
            try await Task.sleep(for: .seconds(1))
            
            loadTags()
        }
        
        
    }
}
