//
//  CoinsView.swift
//

import SwiftUI

struct CoinsView: View {
    
   let vm = CoinAnimationModel()
    @State var radians: Double = 0.5
    @State var saturation: Double = 0
    @State var textOpacity: Double = 0
    @State var degrees: Double = -35
    @State var radiusFactor: Double = 0
    @State var dollarOneOffset: Double = 0
    @State var dollarOneDegree: Double = 0
    @State var dollarOffsetY: Double = 0
    @State var dollarAngle: Double = 0
    @State var transitionOpacity: Double = 0
    var dollars = Array(repeating: Int.random(in: 1...4), count: 10)
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Group {
                    RadialGradient(colors: [Color.white.opacity(0),Color("lightgreen").opacity(0.8),Color("lavand").opacity(0)], center: .center, startRadius: 110 * radiusFactor, endRadius: 870 * radiusFactor)
                        .saturation(saturation)
                        .offset(y: 400 * sin(2*radiusFactor))
                        .blur(radius: 40)
                        .offset(y:  -geo.size.height * 0.4)
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/(duration: 7), value: radiusFactor)
                }
                ForEach(vm.coins, id: \.self) { dollar in
                    Image("coin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .saturation(dollar.saturation)
                        .hueRotation(Angle(degrees: dollar.hueRotation))
                        .rotation3DEffect(.degrees(dollarOneDegree * dollar.angularSpeed),
                                          axis: (
                                            x: dollar.axisX, y: dollar.axisY, z: dollar.axisZ))
                        .offset(x: dollar.initialXOffset, y: dollar.initialYOffset + dollarOneOffset * dollar.speed)
.animation(.easeOut(duration: 175), value: dollarOneOffset)
.animation(.easeOut(duration: 175), value: dollarOneDegree )
                }
            }
            .drawingGroup()
            .onAppear {
                vm.updateDolars()
                radians = 1
                saturation = 1
                degrees = -45
                radiusFactor = 1
                dollarAngle = 360
                dollarOffsetY = 5000
                transitionOpacity = 1
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    textOpacity = 0.8
                    dollarOneOffset = 1300
                    dollarOneDegree = 390
                    radians = 0
                }
            }
            .preferredColorScheme(.dark)
        }
        .ignoresSafeArea()
    }
}
    
#Preview {
    CoinsView()
}
