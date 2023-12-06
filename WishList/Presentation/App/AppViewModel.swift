//
//  AppViewModel.swift
//  WishList
//
//  Created by Quentin Cornu on 06/12/2023.
//

import Foundation

class AppViewModel: ObservableObject {
    
    @Published var sharedListId: String?
    @Published var isShowingListInvitationView = false
    
    func checkDeepLink(url: URL) {
        guard url.scheme == "wishlistapp" else { return }
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("Invalid URL")
            return
        }
        
        guard let action = components.host, action == "share-list" else {
            print("Unknown URL, we can't handle this one")
            return
        }
        
        guard let listId = components.queryItems?.first(where: { $0.name == "id"})?.value else {
            print("List id not found")
            return
        }
        
        self.sharedListId = listId
        self.isShowingListInvitationView = true
        return
    }
}
