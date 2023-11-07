//
//  FirebaseDatabaseDataSource.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import Foundation
import FirebaseDatabase

protocol FirebaseDatabaseDataSourceProtocol {
    func getCreatedLists(forUserId id: String) async throws -> [String: WishListResponse]
    func updateList(id: String, list: WishListResponse) async throws
    func getAllUsers() async throws -> [String: UserResponse]
    func getUser(id: String) async throws -> UserResponse
    func add(list listId: String, toUser userId: String) async throws
    func createNewUser(id: String, email: String, name: String) async throws
    func createNewList(userId: String, listId: String, list: WishListResponse) async throws
}


struct FirebaseDatabaseDataSource {
    private init() {}
    
    static let shared: FirebaseDatabaseDataSource = FirebaseDatabaseDataSource()
}

extension FirebaseDatabaseDataSource: FirebaseDatabaseDataSourceProtocol {
    
    var ref: DatabaseReference! {
        Database.database().reference()
    }
    
    // MARK: FirebaseDatabaseDataSourceProtocol

    func getCreatedLists(forUserId id: String) async throws -> [String: WishListResponse] {
        let createdListsIds = try await getCreatedListsIds(forUserId: id)
        var createdLists: [String: WishListResponse] = [:]
        for id in createdListsIds {
            let newList = try await getList(fromId: id)
            createdLists[id] = newList
        }
        return createdLists
    }
    
    func updateList(id: String, list: WishListResponse) async throws {
        let encodedList = try JSONEncoder().encode(list)
        let serializedList = try JSONSerialization.jsonObject(with: encodedList, options: .allowFragments) as? NSDictionary
        try await ref.child("wish_lists/\(id)").setValue(serializedList)
    }
    
    func getAllUsers() async throws -> [String: UserResponse] {
        let snapshot = try await ref.child("users").getData()
        guard let value = snapshot.value else {
            return [:]
        }
        let data = try JSONSerialization.data(withJSONObject: value)
        let usersResponse = try JSONDecoder().decode([String: UserResponse].self, from: data)
        return usersResponse
    }
    
    func getUser(id: String) async throws -> UserResponse {
        let snapshot = try await ref.child("users/\(id)").getData()
        guard let value = snapshot.value else {
            fatalError("Error")
        }
        let data = try JSONSerialization.data(withJSONObject: value)
        let userResponse = try! JSONDecoder().decode(UserResponse.self, from: data)
        return userResponse
    }
    
    func add(list listId: String, toUser userId: String) async throws {
        try await ref.child("users/\(userId)/shared_lists/\(listId)").setValue(true)
        try await ref.child("wish_lists/\(listId)/shared_with/\(userId)").setValue(true)
    }
    
    func createNewUser(id: String, email: String, name: String) async throws {
        try await ref.child("users").child(id).setValue([
            "email": email,
            "first_name": name
        ])
    }
    
    func createNewList(userId: String, listId: String, list: WishListResponse) async throws {
        try await ref.child("users/\(userId)/created_lists").child(listId).setValue(true)
        try await ref.child("wish_lists/\(listId)").setValue(["name": list.name])
        
        for item in list.items {
            try await ref.child("wish_lists/\(listId)/items").child(item.key).setValue(["name": item.value.name])
        }
    }
    
    // MARK: Private methods
    
    private func getList(fromId id: String) async throws -> WishListResponse {
        let snapshot = try await ref.child("wish_lists/\(id)").getData()
        guard let value = snapshot.value else {
            fatalError("Error")
        }
        let data = try JSONSerialization.data(withJSONObject: value)
        let wishList = try! JSONDecoder().decode(WishListResponse.self, from: data)
        return wishList
    }
    
    private func getCreatedListsIds(forUserId userId: String) async throws -> [String] {
        let snapshot = try await ref.child("users/\(userId)/created_lists").getData()
        guard snapshot.exists() else { return [] }
        let createdListsIds = snapshot.value as! [String: Bool]
        return Array(createdListsIds.keys)
    }
}
