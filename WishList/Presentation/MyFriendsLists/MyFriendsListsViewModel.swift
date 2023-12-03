//
//  MyFriendsListsViewModel.swift
//  WishList
//
//  Created by Quentin Cornu on 07/11/2023.
//

import SwiftUI

@MainActor
class MyFriendsListsViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var hasSharedLists = false
    
    func loadSharedLists() {
        
        self.isLoading = true
        
        guard let currentUserId = AppState.shared.currentUserId else {
            fatalError("No user connected")
        }
        
        Task {
            let datasource = FirebaseDatabaseDataSource.shared
            let sharedListsResults = try await datasource.getSharedLists(forUserId: currentUserId)
            
            for listId in sharedListsResults.keys {
                guard let name = sharedListsResults[listId]?.name else { return }
                guard let creatorId = sharedListsResults[listId]?.creatorId else { return }
                guard let itemsResponses = sharedListsResults[listId]?.items else { return }
                
                let items = try await loadItem(in: itemsResponses)
                                
                let creatorResponse = try await datasource.getUser(id: creatorId)
                let creator = User(
                    id: creatorId,
                    email: creatorResponse.email,
                    name: creatorResponse.firstName
                )

                let newList = SharedList(
                    id: listId, 
                    name: name,
                    creator: creator,
                    items: items
                )
                AppState.shared.sharedLists.append(newList)
            }
            
            self.isLoading = false
            self.hasSharedLists = true
        }
    }
    
    func loadItem(in itemsResponses: [WishListResponse.ItemId : ItemResponse]) async throws -> [Item] {
        var items: [Item] = []
        
        for itemResponse in itemsResponses {
            var offerer: User? = nil
            if let userOffererId = itemResponse.value.offeredByUserId {
                let offererResponse = try await FirebaseDatabaseDataSource.shared.getUser(id: userOffererId)
                offerer = User(id: userOffererId, email: offererResponse.email, name: offererResponse.firstName)
            }
                    
            let newItem = Item(
                id: itemResponse.key,
                name: itemResponse.value.name,
                offeredBy: offerer
            )
            items.append(newItem)
        }
        
        return items
    }
}
