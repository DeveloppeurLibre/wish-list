//
//  ListVavigationLoadedView.swift
//  WishList
//
//  Created by Quentin Cornu on 09/12/2023.
//

import SwiftUI

struct ListVavigationLoadedView: View {
    
    @Environment(\.dismiss) var dismiss
    let userName: String
    let list: PresentList
    
    @State private var isShowingConfirmationView = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text("\(userName) a partagé une liste avec toi !")
                    .font(.system(size: 23))
                    .bold()
                    .multilineTextAlignment(.center)
                WishListPreviewCell(list: list)
                VStack {
                    MainButton(title: "Rejoindre", style: .plain, isActive: .constant(true)) {
                        isShowingConfirmationView = true
                    }
                    Text("\(userName) ne connaîtra pas les cadeaux que tu choisis pour lui.")
                        .font(.callout)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .padding()
            .background(.primaryBackground)
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "multiply")
                        .imageScale(.large)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding()
                })
            }
            .navigationDestination(isPresented: $isShowingConfirmationView) {
                ListNavigationConfirmationView(dismissStack: { dismiss() })
            }
        }
    }
}

#Preview {
    ListVavigationLoadedView(userName: "Preview User", list: .preview)
}
