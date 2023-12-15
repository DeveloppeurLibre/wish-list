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
    @Binding var isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Text(title)
                    .padding(.vertical, 16)
                if isLoading {
                    LoadingAnimation(color: loadingAnimationColor)
                        .frame(width: 35, height: 35)
                        .transition(.opacity)
                }
            }
            .bold()
            .padding(.horizontal, 32)
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
    
    private var loadingAnimationColor: LoadingAnimation.ColorMode {
        switch style {
        case .plain:
            return .white
        case .outline:
            return .mainAccent
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var isLoading = false
        
        var body: some View {
            VStack(spacing: 16) {
                MainButton(title: "Plain Button", style: .plain, isActive: .constant(true), isLoading: .constant(false), action: {})
                MainButton(title: "Outline Button", style: .outline, isActive: .constant(true), isLoading: .constant(false), action: {})
                MainButton(title: "Plain Button", style: .plain, isActive: .constant(true), isLoading: .constant(true), action: {})
                MainButton(title: "Outline Button", style: .outline, isActive: .constant(true), isLoading: $isLoading, action: { isLoading.toggle() })
                
                MainButton(title: "Plain Button (inactive)", style: .plain, isActive: .constant(false), isLoading: .constant(false), action: {})
                MainButton(title: "Outline Button (inactive)", style: .outline, isActive: .constant(false), isLoading: .constant(false), action: {})
            }
            .padding()
        }
    }
    return PreviewWrapper()
}
