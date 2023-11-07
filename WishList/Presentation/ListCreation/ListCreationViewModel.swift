//
//  ListCreationViewModel.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import Foundation

@MainActor
class ListCreationViewModel: ObservableObject {
    
    @Published var appState: AppState? = nil
    
    @Published var listName: String = ""
    @Published var presents: [String] = ["Une idée"]
    @Published var newPresent: String = ""

    func saveList() {
        guard let appState else {
            fatalError("No AppState detected")
        }
        
        guard let userId = appState.currentUserId else {
            fatalError("No current user id")
        }
        
        if !newPresent.isEmpty {
            presents.append(newPresent)
            newPresent = ""
        }
        
        // Create a new PresentList Object
        
        let listId = UUID().uuidString
        let items = presents.map { presentName in
            Item(id: UUID().uuidString, name: presentName)
        }
        
        let newList = PresentList(id: listId, name: listName, items: items)
        self.appState?.presentLists.append(newList)
        print(self.appState?.presentLists.map { $0.name })
        
        // Save PresentList on database
        
        let responseList = WishListResponseMapper.map(list: newList)
        Task {
            try await FirebaseDatabaseDataSource.shared.createNewList(userId: userId, listId: newList.id, list: responseList)
        }
    }
}
