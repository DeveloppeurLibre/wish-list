//
//  Configuration.swift
//  WishList
//
//  Created by Quentin Cornu on 22/12/2023.
//

import Foundation

enum Configuration: String {
    
    // MARK: - Congifurations
    
    case staging
    case production
    case release
    
    // MARK: - Current Configuration
    
    static let current: Configuration = {
        guard let rawValue = Bundle.main.infoDictionary?["Configuration"] as? String else {
            fatalError("No Configuration Found")
        }
        
        guard let configuration = Configuration(rawValue: rawValue.lowercased()) else {
            fatalError("Invalid Configuration")
        }
        
        return configuration
    }()
}
