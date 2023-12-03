//
//  FriendListDetailView.swift
//  WishList
//
//  Created by Quentin Cornu on 08/11/2023.
//

import SwiftUI

struct FriendListDetailView: View {
    
    @StateObject var viewModel: FriendListDetailViewModel
    
    init(list: SharedList) {
        self._viewModel = StateObject(
            wrappedValue: FriendListDetailViewModel(list: list)
        )
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Articles")
                        .font(.textFieldLabel)
                        .padding(.leading)
                    VStack(alignment: .center, spacing: 16) {
                        VStack(alignment: .leading) {
                            ForEach(viewModel.list.items) { item in
                                HStack {
                                    Text(item.name)
                                    Spacer()
                                    if let offerer = item.offeredBy {
                                        Text(offerer.name)
                                    }
                                }
                                .onTapGesture {
                                    viewModel.askToOffer(item: item)
                                }
                                if viewModel.list.items.last != item {
                                    Divider()
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.textFieldBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding()
            }
            .padding(.top)
            .alert("Offrir ce cadeau ? 🎁", isPresented: $viewModel.isShowingPresentSelectionAlert) {
                Button(role: .cancel) {
                    viewModel.cancelOffer()
                } label: {
                    Text("Annuler")
                }
                Button {
                    viewModel.confirmOffer()
                } label: {
                    Text("Je m'en occupe !")
                }
            } message: {
                Text("Si vous sélectionnez ce cadeau (\(viewModel.selectedItem?.name ?? "[erreur]"), \(viewModel.list.creator.name) ne sera pas au courant, mais tous les autres utilisateurs ayant accès à la liste sauront que vous vous occupez du cadeau.")
            }

            .alert("Oups... 😔", isPresented: $viewModel.isShowingPresentAlreadyTakenAlert) {
                Button {
                    viewModel.cancelOffer()
                    viewModel.cancelOffer()
                } label: {
                    Text("Ok")
                }
            } message: {
                Text("Ce cadeau est déjà offert par \(viewModel.selectedItem?.offeredBy?.name ?? "[erreur]")")
            }
        }
        .navigationTitle(viewModel.list.name)
    }
}

#Preview {
    FriendListDetailView(list: .preview1)
}
