//
//  TagCell.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/19/25.
//

import UIKit

class TagCell: UITableViewCell {
    static let reuseIdentifier: String = "tag_cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    func set(tag: Tag) {
        guard let colorIndex = Constants.colorAssetNames.firstIndex(of: tag.tagColor) else { return }
        let color = Constants.colors[colorIndex]
        
        let circle = CircleView(color: color)
        let titleLabel = UILabel()
        
        titleLabel.text = tag.tagTitle
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        circle.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(circle)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            circle.centerYAnchor.constraint(equalTo: centerYAnchor),
            circle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            circle.widthAnchor.constraint(equalToConstant: 50),
            circle.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
