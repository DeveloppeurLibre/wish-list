//
//  MyFriendWishList.swift
//  WishList
//
//  Created by Quentin Cornu on 08/11/2023.
//

import SwiftUI

struct MyFriendWishList: View {
    
    @ObservedObject var list: SharedList
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(list.name)
                    .font(.wishListTitleCell)
                Text("\(list.items.count) éléments")
                    .foregroundStyle(.black.opacity(0.5))
            }
        }
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.cellBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private let colors: [Color] = [
        .orange,
        .green,
        .blue,
        .purple,
        .yellow
    ]
}

#Preview {
    MyFriendWishList(list: SharedList.preview1)
}
