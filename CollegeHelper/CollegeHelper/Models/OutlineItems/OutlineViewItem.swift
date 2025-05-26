//
//  OutlineViewItem.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/19/25.
//


import Foundation

protocol OutlineViewItem {
    var name: String { get }
    var children: [OutlineViewItem]? { get }
    var representedObject: Any? { get }
}
