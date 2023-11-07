//
//  UserResponse.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import Foundation

struct UserResponse: Decodable {
    let createdLists: [String: Bool]?
    let email: String
    let sharedLists: [String: Bool]?
    let firstName: String
    
    enum CodingKeys: String, CodingKey {
        case createdLists = "created_lists"
        case email
        case sharedLists = "shared_lists"
        case firstName = "first_name"
    }
}
