//
//  ListInvitationView.swift
//  WishList
//
//  Created by Quentin Cornu on 06/12/2023.
//

import SwiftUI

struct ListInvitationView: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        Text("Shared list id : \(appViewModel.sharedListId ?? "no id")")
    }
}

#Preview {
    ListInvitationView()
        .environmentObject(AppViewModel())
}
