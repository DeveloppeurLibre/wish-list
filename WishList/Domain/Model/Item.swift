//
//  Item.swift
//  WishList
//
//  Created by Quentin Cornu on 22/10/2023.
//

import Foundation

struct Item: Identifiable {
    let id: String
    let name: String
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}

#if DEBUG
extension Item {
    static let previewItems = [
        Item(id: "001", name: "Item 1"),
        Item(id: "002", name: "Item 2"),
        Item(id: "003", name: "Item 3")
    ]
}
#endif
