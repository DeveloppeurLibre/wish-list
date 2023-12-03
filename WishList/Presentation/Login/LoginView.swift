//
//  LoginView.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if viewModel.mode == .signup {
                TextField("Prénom", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
            }
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
            SecureField("Mot de passe", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
            Button(action: {
                viewModel.confirmForm()
            }, label: {
                Text(viewModel.confirmButtonText)
                    .padding()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .bold()
                    .foregroundColor(.white)
            })
            
            Text(viewModel.errorMessage)
                .foregroundStyle(.red)
            
            HStack {
                Text(viewModel.changeModeTextIndication)
                Button(action: {
                    viewModel.changeMode()
                }, label: {
                    Text(viewModel.changeModeButtonText)
                })
            }
            
        }
        .padding()
        .fullScreenCover(isPresented: $viewModel.isShowingHomeView, content: {
            MyListsView()
        })
    }
}

#Preview {
    LoginView()
}
