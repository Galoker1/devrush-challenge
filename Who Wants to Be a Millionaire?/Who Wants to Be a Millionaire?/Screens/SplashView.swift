//
//  SplashView.swift
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject var vm: GameLogic
    @State var offsetX: CGFloat = -700
    @State var saturation = 0.6
    
    var body: some View {
        ZStack {
            Background(image: BgImage.empty)
                .saturation(saturation)
                .animation(.easeIn(duration: 1.5), value: saturation)
            
            Image("Logo")
                .resizableToFit()
                .padding(48)
                .scaleEffect(0.8)
                .offset(x: offsetX)
                .animation(.spring().delay(0.3), value: offsetX)
                .saturation(saturation)
            
        }
        .onAppear {
            offsetX = 0
            saturation = 1.4
            Timer.scheduledTimer (withTimeInterval: 2, repeats: false) { timer in
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.vm.isSplash = false
                }
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(GameLogic())
}
