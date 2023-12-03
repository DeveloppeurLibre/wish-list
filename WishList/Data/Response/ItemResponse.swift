//
//  ItemResponse.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import Foundation

struct ItemResponse: Codable {
    let name: String
    let offeredByUserId: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case offeredByUserId = "offered_by"
    }
}
