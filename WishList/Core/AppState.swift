//
//  AppState.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import Foundation
import FirebaseAuth

@MainActor
class AppState: ObservableObject {
    @Published var currentUserId: String?
    @Published var presentLists: [PresentList]
    @Published var sharedLists: [SharedList]
    @Published var shopList: [ShopItem]
    
    static let shared = {
        if isPreview {
            AppState(
                currentUserId: UUID().uuidString,
                presentLists: [
                    PresentList(id: "001", name: "Une liste", items: [
                        .init(id: "001", name: "Un item test"),
                        .init(id: "002", name: "Un item test 2"),
                        .init(id: "003", name: "Un item test 3")
                    ]),
                    PresentList(id: "002", name: "Une autre liste", items: [
                        .init(id: "001", name: "Un item test"),
                        .init(id: "002", name: "Un item test 2"),
                        .init(id: "003", name: "Un item test 3")
                    ]),
                ],
                sharedLists: [.preview2]
            )
        } else {
            AppState(currentUserId: Auth.auth().currentUser?.uid)
        }
    }()
    
    init(currentUserId: String? = nil,
         presentLists: [PresentList] = [],
         sharedLists: [SharedList] = [],
         shopList: [ShopItem] = []) {
        self.currentUserId = currentUserId
        self.presentLists = presentLists
        self.sharedLists = sharedLists
        self.shopList = shopList
    }
}

