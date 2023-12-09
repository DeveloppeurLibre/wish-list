//
//  DataSnapshotExtension.swift
//  WishList
//
//  Created by Quentin Cornu on 09/12/2023.
//

import Foundation
import Firebase

extension DataSnapshot {
    var data: Data? {
        guard let value = value, !(value is NSNull) else { return nil }
        return try? JSONSerialization.data(withJSONObject: value)
    }
    var json: String? { data?.string }
}

extension Data {
    var string: String? { String(data: self, encoding: .utf8) }
}
