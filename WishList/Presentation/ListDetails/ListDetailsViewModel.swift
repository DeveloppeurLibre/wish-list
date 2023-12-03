//
//  ListDetailsViewModel.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import Foundation

@MainActor
class ListDetailsViewModel: ObservableObject {
        
    @Published var list: PresentList
    @Published var isShowingShareScreen: Bool
    @Published var isAskingToConfirmDelete: Bool
    
    init(list: PresentList) {
        self.list = list
        self.isShowingShareScreen = false
        self.isAskingToConfirmDelete = false
    }
    
    func updateList() {
        guard let userId = AppState.shared.currentUserId else {
            fatalError("No current user id")
        }
        
        let dataSource = FirebaseDatabaseDataSource.shared
        
        Task {
            let response = WishListResponseMapper.map(creatorId: userId, list: list)
            try await dataSource.updateList(id: list.id, list: response)
        }
    }
    
    func deleteList() {
        // Delete from AppState
        AppState.shared.presentLists.removeAll { list in
            list.id == self.list.id
        }
        
        
        // Delete on database
    }
}
