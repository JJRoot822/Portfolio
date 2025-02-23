//
//  TagsVC+TableViewDelegate.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/19/25.
//

import UIKit

extension TagsVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete Tag") { _, _, completionHandler in
            let deleted = self.deleteTag(self.tags[indexPath.row])
            
            completionHandler(deleted)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, completionHandler in
            self.openEditTagSheet(tag: self.tags[indexPath.row])
            
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash.fill")
        editAction.image = UIImage(systemName: "pencil")
        
        editAction.backgroundColor = .systemBlue
        
        if indexPath.row > 0 {
            return UISwipeActionsConfiguration(actions: [ deleteAction, editAction ])
        }
        
        return nil
    }
}
