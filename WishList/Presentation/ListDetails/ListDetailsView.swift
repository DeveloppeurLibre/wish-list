//
//  ListDetailsView.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import SwiftUI

struct ListDetailsView: View {
    
    @StateObject var viewModel: ListDetailsViewModel
    @EnvironmentObject var appState: AppState
    
    init(list: PresentList) {
        self._viewModel = StateObject(
            wrappedValue: ListDetailsViewModel(list: list)
        )
    }
    
    var body: some View {
        ScrollView {
            VStack {
                sharedWithUsers
                ItemsListEditor(list: viewModel.list, onEdited: {
                    viewModel.updateList()
                })
                .padding()
            }
            .padding(.top)
        }
        .navigationTitle(viewModel.list.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.isShowingShareScreen = true
                }, label: {
                    Text("Partager")
                })
            }
        }
        .onAppear {
            viewModel.appState = self.appState
        }
        .sheet(isPresented: $viewModel.isShowingShareScreen, content: {
            ShareScreenView(list: viewModel.list, viewModel: ShareScreenViewModel(list: viewModel.list))
        })
    }
    
    private var sharedWithUsers: some View {
        HStack {
            ForEach(viewModel.list.sharedWith) { user in
                AsyncImage(url: user.profileURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.gray)
                }
                .frame(width: 32, height: 32)
                .clipShape(Circle())
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListDetailsView(list: .preview)
            .environmentObject(AppState())
    }
}
