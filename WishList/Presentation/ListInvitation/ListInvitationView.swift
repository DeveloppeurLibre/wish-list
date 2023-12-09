//
//  ListInvitationView.swift
//  WishList
//
//  Created by Quentin Cornu on 06/12/2023.
//

import SwiftUI

struct ListInvitationView: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject var viewModel = ListInvitationViewModel()
    
    var body: some View {
        content()
            .task {
                viewModel.loadList(appViewModel.sharedListId)
            }
    }
    
    @ViewBuilder
    private func content() -> some View {
        switch viewModel.mode {
        case .loading:
            Text("Chargement...")
        case .error(let message):
            Text(message)
        case .loaded(let presentList):
            ListVavigationLoadedView(userName: "", list: presentList)
        }
    }
}

#Preview {
    ListInvitationView()
        .environmentObject(AppViewModel())
}
