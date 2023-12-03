//
//  OfferedItemsView.swift
//  WishList
//
//  Created by Quentin Cornu on 22/11/2023.
//

import SwiftUI

struct OfferedItemsView: View {
    
    @StateObject var viewModel: OfferedItemsViewModel = .init()

    var body: some View {
        NavigationStack {
            List {
                ForEach(AppState.shared.shopList, id: \.item.id) { shopItem in
                    VStack(alignment: .leading) {
                        Text(shopItem.item.name)
                            .bold()
                        Text(shopItem.forUser.name)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .navigationTitle("Liste d'achats")
        }
        .onAppear {
            if !viewModel.hasOfferedItemsLists {
                viewModel.loadOfferedItemsLists()
            }
        }
    }
}

#Preview {
    OfferedItemsView()
}
