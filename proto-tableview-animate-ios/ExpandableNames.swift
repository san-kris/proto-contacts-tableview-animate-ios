//
//  ExpandableNames.swift
//  proto-tableview-animate-ios
//
//  Created by Santosh Krishnamurthy on 3/24/23.
//

import Foundation

struct ExpandableNames {
    var isExpanded: Bool
    var names: [Contact]
}

struct Contact {
    let name: String
    var isFavorite: Bool
}
