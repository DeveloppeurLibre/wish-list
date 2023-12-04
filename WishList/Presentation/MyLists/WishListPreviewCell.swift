//
//  WishListPreviewCell.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import SwiftUI

struct WishListPreviewCell: View {
    
    @ObservedObject var list: PresentList
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(list.name)
                    .font(.wishListTitleCell)
                Text("\(list.items.count) éléments")
                    .foregroundStyle(.black.opacity(0.5))
            }
            Spacer()
            ZStack {
                ForEach(list.sharedWith.indices) { index in
                    Circle()
                        .foregroundColor(colors[index % colors.count])
                        .frame(width: 25, height: 25)
                        .overlay {
                            Text("\(String(list.sharedWith[index].email.first ?? "x").uppercased())")
                                .foregroundStyle(.white.opacity(0.5))
                                .bold()
                        }
                        .offset(x: CGFloat(index * -18))
                }
            }
            .offset(x: 8, y: -8)
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
    WishListPreviewCell(list: .preview)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primaryBackground)
}
