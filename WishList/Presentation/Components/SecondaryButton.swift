//
//  SecondaryButton.swift
//  WishList
//
//  Created by Quentin Cornu on 04/12/2023.
//

import SwiftUI

struct SecondaryButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .bold()
                .foregroundStyle(.mainAccent)
        })
    }
}

#Preview {
    SecondaryButton(title: "Secondary Button", action: {})
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primaryBackground)
}
