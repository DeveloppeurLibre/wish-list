//
//  LoginStartView.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import SwiftUI

struct LoginStartView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    // Inspired by : https://storyset.com/illustration/gift/amico
                    Image(.loginIllustration)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    VStack(alignment: .leading) {
                        Text("Fais un voeux !")
                            .font(Font.custom("Roboto", size: 40).weight(.black))
                        Text("& trouve les meilleurs cadeaux à offrir")
                            .font(Font.custom("Roboto", size: 18).weight(.light))
                    }
                }
                .frame(maxHeight: .infinity)
                .background(Color.primaryBackground)
                MainButton(title: "Je m'inscris !", style: .plain, isActive: .constant(true), isLoading: .constant(false)) {
                    viewModel.signupButtonPressed()
                }
                .padding()
                .padding(.bottom, 24)
                .background(.primaryBackground)
                .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 28, bottomLeading: 0, bottomTrailing: 0, topTrailing: 28)))
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
            }
            .ignoresSafeArea()
            .navigationDestination(isPresented: $viewModel.isShowingSignupView) {
                LoginNewAccountView(loginViewModel: viewModel)
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    LoginStartView()
}
