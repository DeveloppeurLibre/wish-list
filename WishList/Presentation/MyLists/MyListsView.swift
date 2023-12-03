//
//  MyListsView.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import SwiftUI

struct MyListsView: View {
    
    @StateObject var viewModel = MyListsViewModel()
        
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    VStack(spacing: 16) {
                        ForEach(AppState.shared.presentLists) { list in
                            NavigationLink {
                                ListDetailsView(list: list)
                            } label: {
                                WishListPreviewCell(list: list)
                            }
                        }
                    }
                    .padding()
                }
            }
            .background(Color.background)
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
            if !viewModel.hasLoadedLists {
                viewModel.loadUserLists()
            }
        }
    }
}

#Preview {
    MyListsView()
}
