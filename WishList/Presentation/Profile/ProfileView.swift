//
//  ProfileView.swift
//  WishList
//
//  Created by Quentin Cornu on 22/10/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        ScrollView {
//            pictureView
            VStack(spacing: 20) {
                CustomTextField(label: "Prénom", title: "Prénom", text: $viewModel.firstName)
                CustomTextField(label: "Email", title: "Adresse email", text: $viewModel.email)
                logoutButton
            }
        }
        .navigationTitle("Mon profil")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $viewModel.isShowingLoginView, content: {
            LoginView()
        })
        .onAppear {
            viewModel.loadCurrentUser()
        }
        .padding()
    }
    
//    private var pictureView: some View {
//        AsyncImage(url: viewModel.currentUser?.profileURL) { image in
//            image
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//        } placeholder: {
//            Rectangle()
//        }
//        .frame(width: 100, height: 100)
//        .clipShape(Circle())
//    }
    
    private var logoutButton: some View {
        Button(action: {
            viewModel.logout()
        }, label: {
            Text("Se déconnecter")
                .foregroundStyle(.red)
        })
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
