//
//  LoadingAnimation.swift
//  WishList
//
//  Created by Quentin Cornu on 10/12/2023.
//

import SwiftUI
import Lottie

struct LoadingAnimation: UIViewRepresentable {
    
    let color: ColorMode
    
    enum ColorMode {
        case white
        case mainAccent
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: fileName)
        
        let keypath = AnimationKeypath(keys: ["**", "Fill", "**", "Color"])
        let colorProvider = ColorValueProvider(UIColor.green.lottieColorValue)
        animationView.setValueProvider(colorProvider, keypath: keypath)
        
        view.addSubview(animationView)
        animationView.play()
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }
    
    private var fileName: String {
        switch color {
        case .white:
            "Loading Circle Animation - White"
        case .mainAccent:
            "Loading Circle Animation - Main Accent"
        }
    }
}

#Preview {
    VStack {
        LoadingAnimation(color: .white)
            .frame(width: 50, height: 50)
            .padding()
            .background(Color.mainAccent)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        LoadingAnimation(color: .mainAccent)
            .frame(width: 50, height: 50)
            .padding()
            .background(Color.primaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
