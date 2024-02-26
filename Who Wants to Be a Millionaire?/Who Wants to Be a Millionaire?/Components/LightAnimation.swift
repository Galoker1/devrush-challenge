//
//  LightAnimation.swift
//

import SwiftUI

struct LightAnimation: View {
    
    @State var radius: Double = 50
    @State var opacity: Double = 0
    @State var rotation: Double = 0
    let color: Color
    
    var body: some View {
        
        RadialGradient(gradient: Gradient(colors: [Color.white ,color]), center: .center, startRadius: 1, endRadius: radius)
            .opacity(opacity)
            .mask {
                Image("light")
                    .resizableToFit()
                    .luminanceToAlpha()
                    .rotationEffect(.degrees(rotation))
                    .scaleEffect(1.2)
            }
            .animation(.easeInOut(duration: 3), value: radius)
            .animation(.easeInOut(duration: 3), value: opacity)
            .animation(.smooth(duration: 2), value: rotation)
            .onAppear {
                radius = 200
                opacity = 1
                rotation = 70
            }
    }
}

#Preview {
    LightAnimation(color: .red)
}
