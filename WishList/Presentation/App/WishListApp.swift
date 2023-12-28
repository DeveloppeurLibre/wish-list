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
        let filePath = Bundle.main.path(forResource: "GoogleService-Info-release", ofType: "plist")!
        let options = FirebaseOptions(contentsOfFile: filePath)!
        FirebaseApp.configure(options: options)
        return true
    }
}

@main
struct WishListApp: App {
    
    @StateObject var viewModel = AppViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if let currentUser = Auth.auth().currentUser {
                MainTabView()
                    .environmentObject(viewModel)
                    .onOpenURL { viewModel.checkDeepLink(url: $0) }
            } else {
                LoginStartView()
            }
        }
    }
}
