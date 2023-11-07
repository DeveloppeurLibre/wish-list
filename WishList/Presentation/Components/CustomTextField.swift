//
//  CustomTextField.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import SwiftUI

struct CustomTextField: View {
    
    let label: String?
    let title: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let label {
                Text(label)
                    .font(.textFieldLabel)
                    .padding(.leading)
            }
            TextField(title, text: $text)
                .padding()
                .background(Color.textFieldBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    @State var text = ""
    return CustomTextField(label: "Nom de la liste", title: "Placeholder", text: $text)
        .padding()
}
