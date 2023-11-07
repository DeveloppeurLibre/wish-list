//
//  AppState.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import Foundation

@MainActor
class AppState: ObservableObject {
    @Published var currentUserId: String?
    @Published var presentLists : [PresentList]
    
    static let shared = AppState()
    
    init(currentUserId: String? = nil, presentLists: [PresentList] = []) {
        self.currentUserId = currentUserId
        self.presentLists = presentLists
    }
}

