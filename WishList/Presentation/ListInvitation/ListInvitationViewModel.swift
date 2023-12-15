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
    @Published var isShowingConfirmationView: Bool
    @Published var invitationMode: InvitationMode
    
    init() {
        self.mode = .loading
        self.isShowingConfirmationView = false
        self.invitationMode = .waitingForValidation
    }
    
    enum Mode {
        case loading
        case error(message: String)
        case loaded(presentList: PresentList)
    }
    
    enum InvitationMode {
        case waitingForValidation
        case loading
        case saved
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
    
    func acceptInvitation(listId: String, userId: String) {
        invitationMode = .loading
        Task {
            try await FirebaseDatabaseDataSource.shared.add(list: listId, toUser: userId)
            invitationMode = .saved
        }
    }
}
