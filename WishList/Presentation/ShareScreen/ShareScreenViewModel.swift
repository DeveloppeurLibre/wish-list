//
//  ShareScreenViewModel.swift
//  WishList
//
//  Created by Quentin Cornu on 22/10/2023.
//

import Foundation

@MainActor
class ShareScreenViewModel: ObservableObject {
    
    typealias IsInvited = Bool
    
    @Published var list: PresentList
    @Published var isShowingInviteAlert: Bool
    @Published var isShowingAlreadyInvitedAlert: Bool
    @Published var results: [User: IsInvited]
    @Published var searchText: String
    
    @Published var selectedUser: User?
    @Published private var allUsers: [String: UserResponse]
    
    init(list: PresentList) {
        self.list = list
        self.isShowingInviteAlert = false
        self.isShowingAlreadyInvitedAlert = false
        self.results = [:]
        self.searchText = ""
        
        self.selectedUser = nil
        self.allUsers = [:]
        
        self.loadContacts()
    }
    
    private func loadContacts() {
        Task {
            let dataSource = FirebaseDatabaseDataSource.shared
            let usersResponse = try await dataSource.getAllUsers()
            self.allUsers = usersResponse
        }
    }
    
    func searchContacts(query: String) {
        let filteredResults = self.allUsers.filter({ element in
            let authDataSource = FirebaseAuthDataSource.shared
            if element.value.email.lowercased() == authDataSource.getCurrentUserEmail() {
                return false
            }
            
            let emails = list.sharedWith.map{ $0.email }
            
            if emails.contains(element.value.email) {
                return false
            }
            return element.value.email.lowercased().contains(searchText.lowercased())
        })
        
        for id in filteredResults.keys {
            guard let response = filteredResults[id] else { return }
            let user = User(id: id, email: response.email, name: response.firstName)
            let isInvited = response.sharedLists?.contains { (listId, _) in
                listId == self.list.id
            } ?? false
            self.results[user] = isInvited
        }
    }
    
    func askToInvite(user: User) {
        if results[user] == true {
            self.isShowingAlreadyInvitedAlert = true
        } else {
            self.isShowingInviteAlert = true
            self.selectedUser = user
        }
    }
    
    func inviteUser() {
        guard let selectedUser else { return }
        
        // Share user on database
        Task {
            let dataSource = FirebaseDatabaseDataSource.shared
            try await dataSource.add(list: list.id, toUser: selectedUser.id)
        }
        
        // Share user on AppState
        list.sharedWith.append(selectedUser)
    }
    
    func cancelInvite() {
        self.isShowingInviteAlert = false
    }
}

extension ShareScreenViewModel {
    
    static var withResults: ShareScreenViewModel = {
        var viewModel: ShareScreenViewModel = .init(list: .preview)
        viewModel.searchText = "my@friend.com"
        viewModel.results[User(id: "001", email: "my@friend.com", name: "Manon")] = false
        viewModel.results[User(id: "002", email: "mybest@friend.com", name: "Alex")] = true
        viewModel.results[User(id: "003", email: "my@brother.com", name: "Lou")] = false
        return viewModel
    }()
}
