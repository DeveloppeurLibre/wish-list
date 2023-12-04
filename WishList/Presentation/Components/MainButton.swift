//
//  MainButton.swift
//  WishList
//
//  Created by Quentin Cornu on 03/12/2023.
//

import SwiftUI

struct MainButton: View {
    
    let title: String
    let style: Style
    @Binding var isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
            .bold()
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .overlay {
                    if style == .outline {
                        RoundedRectangle(cornerRadius: .infinity)
                            .stroke(lineWidth: 2.0)
                    }
                }
                .overlay(alignment: .trailing) {
                    Image(systemName: "chevron.right")
                        .imageScale(.small)
                        .padding(.trailing)
                }
                .foregroundColor(textColor)
                .background {
                    if style == .plain {
                        RoundedRectangle(cornerRadius: .infinity)
                            .foregroundStyle(.mainAccent)
                    }
                }
        })
        .disabled(!isActive)
        .opacity(isActive ? 1.0 : 0.5)
    }
    
    enum Style {
        case plain
        case outline
    }
    
    private var textColor: Color {
        switch style {
        case .plain:
            return .white
        case .outline:
            return .mainAccent
        }
    }
}

#Preview {
    
    @State var plainButtonIsActive = true
    @State var outlineButtonIsActive = false
    
    return VStack(spacing: 16) {
        MainButton(title: "Plain Button", style: .plain, isActive: $plainButtonIsActive, action: {})
        MainButton(title: "Outline Button", style: .outline, isActive: $outlineButtonIsActive, action: {})
    }
    .padding()
}
