//
//  WishListApp.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct WishListApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if let currentUser = Auth.auth().currentUser {
                MainTabView()
            } else {
                LoginStartView()
            }
        }
    }
}
