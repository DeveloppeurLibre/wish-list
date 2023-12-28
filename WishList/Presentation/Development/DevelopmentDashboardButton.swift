//
//  DevelopmentDashboardButton.swift
//  WishList
//
//  Created by Quentin Cornu on 28/12/2023.
//

import SwiftUI

struct DevelopmentDashboardButton: View {
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .semibold))
                .padding(20)
                .background(Color.mainAccent)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 10)
        }
    }
}

#Preview {
    
    struct ContainerView: View {
        
        @State private var position: CGPoint = CGPoint(x: 10, y: 100)
        @State private var buttonSize: CGSize = CGSize()
        
        var body: some View {
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .foregroundColor(.white)
                DevelopmentDashboardButton()
                    .background() {
                        GeometryReader { geometry in
                            Path { path in
                                let size = geometry.size
                                DispatchQueue.main.async {
                                    if self.buttonSize != size {
                                        self.buttonSize = size
                                        self.position = CGPoint(
                                            x: 0 + buttonSize.width / 2,
                                            y: 0 + buttonSize.height / 2
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .position(position)
            }
        }
    }
    
    return ContainerView()
}
