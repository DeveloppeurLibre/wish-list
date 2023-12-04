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
    var isSecured: Bool
    @Binding var text: String
    
    init(label: String?, title: String, text: Binding<String>, isSecured: Bool = false) {
        self.label = label
        self.title = title
        self._text = text
        self.isSecured = isSecured
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let label {
                Text(label)
                    .font(.textFieldLabel)
                    .padding(.leading)
            }
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }
            .padding()
            .background(Color.cellBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    @State var text = ""
    return CustomTextField(
        label: "Nom de la liste",
        title: "Placeholder",
        text: $text
    )
    .padding()
    .background(Color.primaryBackground)
}
