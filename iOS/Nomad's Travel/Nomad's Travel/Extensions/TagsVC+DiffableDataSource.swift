//
//  TagsVC+DiffableDataSource.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/22/25.
//

import UIKit

extension TagsVC {
    enum Section {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Tag>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Tag>
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, tag -> UITableViewCell? in
            if tag.tagTitle.contains("All") {
                let cell = tableView.dequeueReusableCell(withIdentifier: AllDestinationsCell.reuseIdentifier, for: indexPath) as? AllDestinationsCell
                cell?.set()
                
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TagCell.reuseIdentifier, for: indexPath) as? TagCell
            cell?.set(tag: tag)
            
            return cell
        }
        
        return dataSource
    }
    
    func applySnapshot(animated: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([ .main ])
        snapshot.appendItems(tags)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
