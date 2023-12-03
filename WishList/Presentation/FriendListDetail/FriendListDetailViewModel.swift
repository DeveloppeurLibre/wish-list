//
//  FriendListDetailViewModel.swift
//  WishList
//
//  Created by Quentin Cornu on 08/11/2023.
//

import Foundation

@MainActor
class FriendListDetailViewModel: ObservableObject {
        
    @Published var list: SharedList
    @Published var isShowingPresentSelectionAlert: Bool
    @Published var isShowingPresentAlreadyTakenAlert: Bool
    
    @Published var selectedItem: Item?
    
    init(list: SharedList) {
        self.list = list
        self.isShowingPresentSelectionAlert = false
        self.isShowingPresentAlreadyTakenAlert = false
    }
    
    func askToOffer(item: Item) {
        self.selectedItem = item
        if item.offeredBy == nil {
            self.isShowingPresentSelectionAlert = true
        } else {
            self.isShowingPresentAlreadyTakenAlert = true
        }
    }
    
    func confirmOffer() {
        guard let userId = AppState.shared.currentUserId else {
            fatalError("No current user id")
        }
        guard let selectedItem else { return }
        
        Task {
            let currentUserResponse = try await FirebaseDatabaseDataSource.shared.getUser(id: userId)
            let currentUser = User(id: userId, email: currentUserResponse.email, name: currentUserResponse.firstName)
            self.selectedItem?.offeredBy = currentUser
            self.selectedItem = nil
            self.isShowingPresentSelectionAlert = false
                        
            try await FirebaseDatabaseDataSource.shared.updateOfferer(
                listId: list.id,
                itemId: selectedItem.id,
                offererId: currentUser.id
            )
            
            try await FirebaseDatabaseDataSource.shared.addItemToListOfOffers(
                offererId: currentUser.id,
                listId: list.id,
                itemId: selectedItem.id
            )
        }
    }
    
    func cancelOffer() {
        self.selectedItem = nil
        self.isShowingPresentSelectionAlert = false
        self.isShowingPresentAlreadyTakenAlert = false
    }
//    func updateList() {
//        guard let userId = AppState.shared.currentUserId else {
//            fatalError("No current user id")
//        }
//        
//        let dataSource = FirebaseDatabaseDataSource.shared
//        
//        Task {
//            let response = WishListResponseMapper.map(creatorId: userId, list: list)
//            try await dataSource.updateList(id: list.id, list: response)
//        }
//    }
}
