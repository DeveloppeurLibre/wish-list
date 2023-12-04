//
//  ListDetailsView.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import SwiftUI

struct ListDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: ListDetailsViewModel
    
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
        .background(Color.primaryBackground)
        .navigationTitle(viewModel.list.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("Partager") {
                        viewModel.isShowingShareScreen = true
                    }
                    Button(role: .destructive) {
                        viewModel.isAskingToConfirmDelete = true
                    } label: {
                        Text("Supprimer")
                    }
                } label: {
                    Image(systemName: "person.2.badge.gearshape")
                }
            }
        }
        .alert("Attention !", isPresented: $viewModel.isAskingToConfirmDelete) {
            Button(role: .cancel) {
                viewModel.isAskingToConfirmDelete = false
            } label: {
                Text("Annuler")
            }
            Button(role: .destructive) {
                viewModel.deleteList()
                dismiss()
                // BUG : ne se supprime pas quand on quitte l'écran
            } label: {
                Text("Supprimer")
            }
        } message: {
            Text("Etes-vous sûr de vouloir supprimer la liste définitivement ?")
        }
        .sheet(isPresented: $viewModel.isShowingShareScreen, content: {
            ShareScreenView(list: viewModel.list, viewModel: ShareScreenViewModel(list: viewModel.list))
        })
    }
    
    private var sharedWithUsers: some View {
        HStack {
            ForEach(viewModel.list.sharedWith.indices) { index in
                AsyncImage(url: viewModel.list.sharedWith[index].profileURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Circle()
                        .foregroundColor(colors[index % colors.count])
                        .overlay {
                            Text("\(String(viewModel.list.sharedWith[index].email.first ?? "x").uppercased())")
                                .foregroundStyle(.white.opacity(0.5))
                                .bold()
                        }
                }
                .frame(width: 32, height: 32)
                .clipShape(Circle())
            }
        }
    }
    
    private let colors: [Color] = [
        .orange,
        .green,
        .blue,
        .purple,
        .yellow
    ]
}

#Preview {
    NavigationStack {
        ListDetailsView(list: .preview)
    }
}
