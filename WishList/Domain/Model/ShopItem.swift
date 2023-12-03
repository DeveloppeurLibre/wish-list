//
//  ShopItem.swift
//  WishList
//
//  Created by Quentin Cornu on 22/11/2023.
//

import Foundation

struct ShopItem {
    let item: Item
    let forUser: User
}

extension ShopItem {
    static let previewCart: [ShopItem] = [
        .init(item: .previewItems[0], forUser: .preview001),
        .init(item: .previewItems[1], forUser: .preview002),
        .init(item: .previewItems[2], forUser: .preview001)
    ]
}
