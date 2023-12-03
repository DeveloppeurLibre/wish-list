//
//  MyListsViewModel.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import Foundation
import FirebaseDatabase

var isPreview: Bool {
    return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}

@MainActor
class MyListsViewModel: ObservableObject {
    
    @Published var hasLoadedLists = false
    @Published var isLoading: Bool
    @Published var isCreatingNewList = false
    @Published var userLists: [PresentList]
    @Published var isPresentingProfile = false
    
    init() {
        self.isLoading = false
        self.isCreatingNewList = false
        self.userLists = []
    }

    func loadUserLists() {
        if !isPreview {
            self.isLoading = true
            
            guard let userId = AppState.shared.currentUserId else {
                fatalError("No current user id")
            }
            
            let dataSource = FirebaseDatabaseDataSource.shared
            
            Task {
                let lists = try await dataSource.getCreatedLists(forUserId: userId)
                for (listId, listResponse) in lists {
                    var users: [User] = []
                    if let sharedWithUserIds = listResponse.sharedWith?.keys {
                        for id in sharedWithUserIds {
                            let userResponse = try await dataSource.getUser(id: id)
                            users.append(User(id: id, email: userResponse.email, name: userResponse.firstName))
                        }
                    }
                    AppState.shared.presentLists.append(WishListResponseMapper.map(id: listId, response: listResponse, sharedWithUsers: users))
                }
                
                self.isLoading = false
                self.hasLoadedLists = true
            }
        } else {
            self.userLists = [.preview]
            self.hasLoadedLists = true
        }
    }
}
