//
//  WishListResponse.swift
//  WishListResponse
//
//  Created by Quentin Cornu on 20/10/2023.
//

import Foundation

struct WishListResponse: Codable {
    typealias ItemId = String
    typealias UserId = String
    let items: [ItemId: ItemResponse]
    let name: String
    let sharedWith: [UserId: Bool]?
    
    enum CodingKeys: String, CodingKey {
        case items
        case name
        case sharedWith = "shared_with"
    }
}
