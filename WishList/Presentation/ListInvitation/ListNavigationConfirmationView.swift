//
//  ListNavigationConfirmationView.swift
//  WishList
//
//  Created by Quentin Cornu on 09/12/2023.
//

import SwiftUI

struct ListNavigationConfirmationView: View {
    
    let dismissStack: () -> Void

    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 8) {
                Text("La liste a été ajoutée !")
                    .font(.system(size: 23))
                    .bold()
                    .multilineTextAlignment(.center)
                Text("Tu peux maintenant la retrouver dans l'onglet \"Mes amis\"")
                    .font(.callout)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            MainButton(title: "Retourner à mes listes", style: .outline, isActive: .constant(true), isLoading: .constant(false)) {
                dismissStack()
            }
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .padding()
        .background(.primaryBackground)
    }
}

#Preview {
    NavigationStack {
        ListNavigationConfirmationView(dismissStack: {})
    }
}
