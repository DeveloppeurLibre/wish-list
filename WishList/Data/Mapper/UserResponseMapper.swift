//
//  UserResponseMapper.swift
//  WishList
//
//  Created by Quentin Cornu on 21/11/2023.
//

import Foundation

class UserResponseMapper {
    static func map(id: String, response: UserResponse) -> User {
        return User(
            id: id,
            email: response.email,
            name: response.firstName
        )
    }
}
