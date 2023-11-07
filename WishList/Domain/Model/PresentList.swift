//
//  PresentList.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import Foundation

class PresentList: ObservableObject {
    let id: String
    let name: String
    @Published var items: [Item]
    @Published var sharedWith: [User]
    
    init(id: String, name: String, items: [Item], sharedWidth: [User] = []) {
        self.id = id
        self.name = name
        self.items = items
        self.sharedWith = sharedWidth
    }
}

extension PresentList {
    static var preview: PresentList = .init(
        id: "001",
        name: "Preview List",
        items: Item.previewItems, 
        sharedWidth: [
            User(id: "001", email: "mon@mail.com", name: "Quentin", profileURL: URL(string: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")),
            User(id: "002", email: "son@mail.com", name: "Nico")
        ]
    )
}
