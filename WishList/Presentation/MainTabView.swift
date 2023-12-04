//
//  MainTabView.swift
//  WishList
//
//  Created by Quentin Cornu on 07/11/2023.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MyListsView()
                .tabItem { Label("Mes listes", systemImage: "menucard.fill") }
            MyFriendsListsView()
                .tabItem { Label("Mes amis", systemImage: "person.text.rectangle") }
        }
        .tint(.secondaryAccent)
    }
}

#Preview {
    MainTabView()
}
