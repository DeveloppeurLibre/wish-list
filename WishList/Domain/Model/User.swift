//
//  User.swift
//  WishList
//
//  Created by Quentin Cornu on 22/10/2023.
//

import Foundation

struct User: Identifiable, Hashable {
    let id: String
    let email: String
    let name: String
    let profileURL: URL?
    
    init(id: String, email: String, name: String, profileURL: URL? = nil) {
        self.id = id
        self.email = email
        self.name = name
        self.profileURL = profileURL
    }
}

#if DEBUG

extension User {
    static let preview001: User = User(id: "001", email: "user001@mail.com", name: "Preview User 001")
    static let preview002: User = User(id: "002", email: "user002@mail.com", name: "Preview User 002")
    static let preview003: User = User(id: "003", email: "user003@mail.com", name: "Preview User 003")
}

#endif
