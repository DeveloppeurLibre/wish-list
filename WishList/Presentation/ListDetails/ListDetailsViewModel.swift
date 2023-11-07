//
//  ListDetailsViewModel.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import Foundation

@MainActor
class ListDetailsViewModel: ObservableObject {
    
    @Published var appState: AppState? = nil
    
    @Published var list: PresentList
    @Published var isShowingShareScreen: Bool
    
    init(list: PresentList) {
        self.list = list
        self.isShowingShareScreen = false
    }
    
    func updateList() {
        guard let appState else {
            fatalError("No AppState detected")
        }
        
        guard let userId = appState.currentUserId else {
            fatalError("No current user id")
        }
        
        let dataSource = FirebaseDatabaseDataSource.shared
        
        Task {
            let response = WishListResponseMapper.map(list: list)
            try await dataSource.updateList(id: list.id, list: response)
        }
    }
}
