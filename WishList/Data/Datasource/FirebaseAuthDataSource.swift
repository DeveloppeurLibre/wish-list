//
//  FirebaseAuthDataSource.swift
//  WishList
//
//  Created by Quentin Cornu on 22/10/2023.
//

import Foundation
import FirebaseAuth

protocol FirebaseAuthDataSourceProtocol {
    func getCurrentUserEmail() -> String?
    func getCurrentUserId() -> String?
    func logout() async throws
}

struct FirebaseAuthDataSource {
    private init() {}
    
    static let shared: FirebaseAuthDataSource = FirebaseAuthDataSource()
}


extension FirebaseAuthDataSource: FirebaseAuthDataSourceProtocol {
    
    // MARK: FirebaseAuthDataSourceProtocol
    
    func getCurrentUserEmail() -> String? {
        Auth.auth().currentUser?.email
    }
    
    func getCurrentUserId() -> String? {
        Auth.auth().currentUser?.uid
    }

    func logout() async throws {
        try Auth.auth().signOut()
    }
}
