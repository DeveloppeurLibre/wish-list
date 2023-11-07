//
//  ProfileViewModel.swift
//  WishList
//
//  Created by Quentin Cornu on 22/10/2023.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    
    @Published var isShowingLoginView: Bool
    @Published var firstName: String
    @Published var profileImageURL: URL?
    @Published var email: String
    
    init() {
        self.isShowingLoginView = false
        self.firstName = ""
        self.profileImageURL = nil
        self.email = ""
    }
    
    func logout() {
        Task {
            try await FirebaseAuthDataSource.shared.logout()
            self.isShowingLoginView = true
        }
    }
    
    func loadCurrentUser() {
        Task {
            let currentUserId = FirebaseAuthDataSource.shared.getCurrentUserId()
            if let currentUserId {
                let currentUser = try await FirebaseDatabaseDataSource.shared.getUser(id: currentUserId)
                self.firstName = currentUser.firstName
                self.email = currentUser.email
                // TODO: To complete
                self.profileImageURL = nil
            }
        }
    }
}
