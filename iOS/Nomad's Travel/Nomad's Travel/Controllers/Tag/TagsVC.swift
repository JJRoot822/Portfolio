//
//  TagsVC.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/19/25.
//

import UIKit

class TagsVC: UITableViewController, CreateTagDelegate {
    let dataController = DataController()
    
    var tags: [Tag] = []
    var reloadTask:Task<Void, Error>?
    
    lazy var dataSource = makeDataSource()
    var searchController: UISearchController!
    var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        configureNavigationTitle()
        configureSearchController()
        configureTableView()
        configureRefreshControl()
        configureAddTagButton()
    }
    
    private func configureNavigationTitle() {
        title = "Nomad's Travel"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        self.tableView.dataSource = dataSource
        self.tableView.register(AllDestinationsCell.self, forCellReuseIdentifier: AllDestinationsCell.reuseIdentifier)
        self.tableView.register(TagCell.self, forCellReuseIdentifier: TagCell.reuseIdentifier)
    }
    
    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTags), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    private func configureAddTagButton() {
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAddTagSheet))
        addButton.accessibilityLabel = "Add Tag"
        navigationItem.rightBarButtonItem = addButton
    }
    
    func loadTags() {
        guard let searchTerm = searchController.searchBar.text else { return }
        
        self.tags = dataController.tags(searchTerm: searchTerm)
        applySnapshot()
    }

    @objc func refreshTags() {
        loadTags()
        tableView.refreshControl?.endRefreshing()
    }

    func deleteTag(_ tag: Tag) -> Bool {
        do {
            try dataController.delete(tag)
            tags.removeAll { $0 == tag }
            
            loadTags()
            
            return true
        } catch {
            let alert = UIAlertController(title: "Failed to Delete the Tag", message: "Something went wrong when trying to delete the tag. Please try again later.", preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .default))
            present(alert, animated: true)
            
            dataController.rollback()
            
            return false
        }
    }

    func openEditTagSheet(tag: Tag) {
        
    }
    
    @objc private func openAddTagSheet() {
        let addTagVC = CreateTagVC()
        addTagVC.delegate = self
        present(addTagVC, animated: true)
    }
    
    func didFinishCreatingTag() {
        loadTags()
    }
}
