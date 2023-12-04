//
//  MyFriendsListsView.swift
//  WishList
//
//  Created by Quentin Cornu on 07/11/2023.
//

import SwiftUI

struct MyFriendsListsView: View {
    
    @StateObject var viewModel = MyFriendsListsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    VStack(spacing: 20) {
                        ForEach(AppState.shared.sharedLists) { list in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(list.creator.name)
                                    .foregroundStyle(.gray)
                                    .padding(.leading)
                                NavigationLink {
                                    FriendListDetailView(list: list)
                                } label: {
                                    MyFriendWishList(list: list)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Mes amis")
            .background(Color.primaryBackground)
        }
        .onAppear {
            if !viewModel.hasSharedLists {
                viewModel.loadSharedLists()
            }
        }
    }
}

#Preview {
    MyFriendsListsView()
}
