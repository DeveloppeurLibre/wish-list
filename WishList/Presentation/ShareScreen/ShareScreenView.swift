//
//  ShareScreenView.swift
//  WishList
//
//  Created by Quentin Cornu on 22/10/2023.
//

import SwiftUI

struct ShareScreenView: View {
    
    let list: PresentList
    
    @StateObject var viewModel: ShareScreenViewModel
    
    init(list: PresentList, viewModel: ShareScreenViewModel) {
        self.list = list
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Partagez votre liste avec vos amis et votre famille ! Recherchez leur adresse mail et envoyez leur invitation.")
                .font(.indicationText)
                .foregroundStyle(.black.opacity(0.5))
            CustomTextField(
                label: "Email",
                title: "Recherchez par email",
                text: $viewModel.searchText
            )
            List {
                ForEach(list.sharedWith) { user in
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Text(user.name)
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    })
                }
                ForEach(Array(viewModel.results.keys)) { user in
                    Button(action: {
                        viewModel.askToInvite(user: user)
                    }, label: {
                        HStack {
                            Text(user.email)
                            Spacer()
                            if viewModel.results[user] ?? false {
                                Image(systemName: "checkmark")
                            }
                        }
                    })
                }
            }
            .listStyle(.plain)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .onChange(of: viewModel.searchText) { oldValue, newValue in
            viewModel.searchContacts(query: newValue)
        }
        .alert("Inviter \(viewModel.selectedUser?.email ?? "[erreur]")", isPresented: $viewModel.isShowingInviteAlert) {
            Button(role: .cancel) {
                viewModel.cancelInvite()
            } label: {
                Text("Annuler")
            }
            Button {
                viewModel.inviteUser()
            } label: {
                Text("Envoyer")
            }
        } message: {
            Text("\(viewModel.selectedUser?.email ?? "[erreur]") aura accès à votre liste de cadeaux.")
        }
        .alert("C'est déjà fait", isPresented: $viewModel.isShowingAlreadyInvitedAlert) {
            Button {} label: {
                Text("Ok")
            }
        } message: {
            Text("Vous avez déjà partagé votre liste avec \(viewModel.selectedUser?.email ?? "[erreur]")")
        }
    }
}

#Preview {
    @StateObject var viewModel = ShareScreenViewModel.withResults
    
    return ShareScreenView(list: .preview, viewModel: viewModel)
}
