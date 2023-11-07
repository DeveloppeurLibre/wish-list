//
//  HomeView.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    VStack {
                        ForEach(viewModel.userLists, id: \.name) { list in
                            NavigationLink {
                                ListDetailsView(list: list)
                            } label: {
                                WishListPreviewCell(list: list)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .bottomTrailing) {
                Button(action: {
                    viewModel.isCreatingNewList = true
                }, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().foregroundColor(.blue))
                        .padding()
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 10)
                })
            }
            .navigationTitle("Mes listes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.isPresentingProfile = true
                    } label: {
                        Image(systemName: "person.fill")
                    }
                }
                
            }
            .sheet(isPresented: $viewModel.isCreatingNewList, content: {
                ListCreationView()
            })
            .sheet(isPresented: $viewModel.isPresentingProfile, content: {
                NavigationStack {
                    ProfileView()
                }
            })
        }
        .onAppear {
            viewModel.appState = self.appState
            viewModel.appState?.currentUserId = FirebaseAuthDataSource.shared.getCurrentUserId()
            viewModel.loadUserLists()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
