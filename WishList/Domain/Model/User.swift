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
