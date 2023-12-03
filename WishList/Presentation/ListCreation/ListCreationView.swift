//
//  ListCreationView.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import SwiftUI

struct ListCreationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = ListCreationViewModel()
        
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                Text(viewModel.listName.isEmpty ? "Nouvelle Liste" : viewModel.listName)
                    .font(.header)
                
                CustomTextField(label: "Nom de la liste", title: "Nom de la liste", text: $viewModel.listName)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Articles")
                        .font(.textFieldLabel)
                        .padding(.leading)
                    VStack(alignment: .leading) {
                        ForEach(viewModel.presents, id: \.self) { present in
                            Text(present)
                            Divider()
                        }
                        TextField("Nouveau cadeau", text: $viewModel.newPresent)
                            .onSubmit {
                                viewModel.presents.append(viewModel.newPresent)
                                viewModel.newPresent = ""
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.textFieldBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                }
            }
            .padding()
        }
        .overlay(alignment: .bottom) {
            Button(action: {
                viewModel.saveList()
                dismiss()
            }, label: {
                Text("Sauvegarder")
                    .padding(.horizontal)
                    .padding()
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .foregroundColor(.white)
                    .bold()
            })
            .padding()
        }
    }
}

#Preview {
    ListCreationView()
}
