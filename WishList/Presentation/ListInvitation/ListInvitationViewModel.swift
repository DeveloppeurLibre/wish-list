//
//  ListInvitationViewModel.swift
//  WishList
//
//  Created by Quentin Cornu on 06/12/2023.
//

import Foundation

@MainActor
class ListInvitationViewModel: ObservableObject {
    
    @Published var mode: Mode
    
    init() {
        self.mode = .loading
    }
    
    enum Mode {
        case loading
        case error(message: String)
        case loaded(presentList: PresentList)
    }
    
    func loadList(_ listId: String?) {
        self.mode = .loading
        guard let sharedListId = listId else {
            self.mode = .error(message: "Aucune liste n'a été fournie...")
            return
        }
        Task {
            do {
                let response = try await FirebaseDatabaseDataSource.shared.getList(fromId: sharedListId)
                let presentList = WishListResponseMapper.map(id: sharedListId, response: response, sharedWithUsers: [])
                self.mode = .loaded(presentList: presentList)
            } catch FirebaseDatabaseDataSourceError.listNotFound {
                self.mode = .error(message: "La liste n'a pas été trouvée...")
            }
        }
    }
}
