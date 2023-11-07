//
//  WishListResponseMapper.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import Foundation

class WishListResponseMapper {
    static func map(id: String, response: WishListResponse, sharedWithUsers: [User]) -> PresentList {
        return PresentList(
            id: id,
            name: response.name,
            items: response.items.map { Item(id: $0.key, name: $0.value.name) }, 
            sharedWidth: sharedWithUsers
        )
    }
    
    static func map(list: PresentList) -> WishListResponse {
        var itemsResponse = [String: ItemResponse]()
        list.items.forEach { item in
            itemsResponse[item.id] = ItemResponse(name: item.name)
        }
        var sharedWith: [WishListResponse.UserId: Bool] = [:]
        for user in list.sharedWith {
            sharedWith[user.id] = true
        }
        
        return WishListResponse(
            items: itemsResponse,
            name: list.name, 
            sharedWith: sharedWith
        )
    }
}
