//
//  LoginNewAccountView.swift
//  WishList
//
//  Created by Quentin Cornu on 04/12/2023.
//

import SwiftUI

struct LoginNewAccountView: View {
    
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            if loginViewModel.mode == .signup {
                CustomTextField(
                    label: "Prénom",
                    title: "Prénom",
                    text: $loginViewModel.name
                )
            }
            CustomTextField(
                label: "Email", 
                title: "votre@email.com",
                text: $loginViewModel.email
            )
            CustomTextField(
                label: "Mot de passe", 
                title: "Mot de passe",
                text: $loginViewModel.password,
                isSecured: true
            )
            if !loginViewModel.errorMessage.isEmpty {
                Text(loginViewModel.errorMessage)
                    .foregroundStyle(.red)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            VStack(spacing: 16) {
                MainButton(title: loginViewModel.confirmButtonText,
                           style: .plain,
                           isActive: .constant(signupButtonIsActive)) {
                    loginViewModel.confirmForm()
                }
                SecondaryButton(title: "J'ai déjà un compte") {
                    loginViewModel.changeMode()
                }
            }
            .padding()
            .padding(.bottom, 24)
            .background(.primaryBackground)
            .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 28, bottomLeading: 0, bottomTrailing: 0, topTrailing: 28)))
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
        }
        .ignoresSafeArea()
        .background(Color.primaryBackground)
        .navigationDestination(isPresented: $loginViewModel.isShowingHomeView) {
            MyListsView()
                .navigationBarBackButtonHidden()
        }
    }
    
    private var signupButtonIsActive: Bool {
        switch loginViewModel.mode {
        case .login:
            return !loginViewModel.email.isEmpty && !loginViewModel.password.isEmpty
        case .signup:
            return !loginViewModel.name.isEmpty
            && !loginViewModel.email.isEmpty
            && !loginViewModel.password.isEmpty
        }
    }
}

#Preview {
    LoginNewAccountView(loginViewModel: LoginViewModel())
}
