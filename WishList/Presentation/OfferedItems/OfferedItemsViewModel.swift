//
//  OfferedItemsViewModel.swift
//  WishList
//
//  Created by Quentin Cornu on 22/11/2023.
//

import Foundation

@MainActor
class OfferedItemsViewModel: ObservableObject {
    
    @Published var hasOfferedItemsLists = false

    func loadOfferedItemsLists() {
        Task {
            let shopList: [ShopItem] = ShopItem.previewCart
            AppState.shared.shopList = shopList
            self.hasOfferedItemsLists = true
        }
    }
}
