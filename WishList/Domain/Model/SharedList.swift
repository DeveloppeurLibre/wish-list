//
//  SharedList.swift
//  WishList
//
//  Created by Quentin Cornu on 07/11/2023.
//

import Foundation

class SharedList: ObservableObject, Identifiable {
    let id: String
    let name: String
    let creator: User
    @Published var items: [Item]
    
    init(id: String, name: String, creator: User, items: [Item]) {
        self.id = id
        self.name = name
        self.creator = creator
        self.items = items
    }
}


extension SharedList {
    static var preview1: SharedList = .init(
        id: "001",
        name: "Shared List",
        creator: .preview001,
        items: Item.previewItems
    )
    
    static var preview2: SharedList = .init(
        id: "002",
        name: "Another shared List",
        creator: .preview001,
        items: Item.previewItems
    )
    
    static var preview3: SharedList = .init(
        id: "003",
        name: "Third shared List",
        creator: .preview001,
        items: Item.previewItems
    )
}

