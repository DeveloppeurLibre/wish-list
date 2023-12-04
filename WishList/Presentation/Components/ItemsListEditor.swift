//
//  ItemsListEditor.swift
//  WishList
//
//  Created by Quentin Cornu on 22/10/2023.
//

import SwiftUI

struct ItemsListEditor: View {
    
    @ObservedObject var list: PresentList
    
    @State var isEditing: Bool = false
    @State private var newPresent = ""
    
    var onEdited: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Articles")
                .font(.textFieldLabel)
                .padding(.leading)
            VStack(alignment: .center, spacing: 16) {
                VStack(alignment: .leading) {
                    ForEach(list.items) { item in
                        Text(item.name)
                        if list.items.last != item {
                            Divider()
                        }
                    }
                    if isEditing {
                        Divider()
                        TextField("Nouveau cadeau", text: $newPresent)
                            .onSubmit {
                                list.items.append(Item(
                                    id: UUID().uuidString,
                                    name: newPresent)
                                )
                                newPresent = ""
                                onEdited()
                            }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.textFieldBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                if isEditing {
                    Button("Annuler") {
                        self.isEditing = false
                    }
                    .foregroundStyle(.mainAccent)
                } else {
                    Button("Ajouter une idée") {
                        self.isEditing = true
                    }
                    .foregroundStyle(.mainAccent)
                }
            }
        }
    }
}

#Preview {
    @StateObject var previewList = PresentList.preview
    
    return VStack {
        ItemsListEditor(list: previewList, onEdited: {}).padding()
    }
}
