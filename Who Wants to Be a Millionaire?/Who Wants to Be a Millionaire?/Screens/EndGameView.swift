//
//  EndGameView.swift
//

import SwiftUI

struct EndGameView: View {
    
    @State var opacity: Double = 0
    @EnvironmentObject var vm: GameLogic
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Background(image: BgImage.empty)
            
            LightAnimation(color: .red)
            
            Text("LOSE")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .opacity(opacity)
                .animation(.easeInOut(duration: 1).delay(3), value: opacity)

            
            VStack {
                Image("Logo")
                    .resizableToFit()
                    .frame(width: UIScreen.main.bounds.width*0.6)
                
                Text("You losed on \(vm.currentQuestion) question")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding(.top)
                
                Spacer()
                
                PlayAgainBtn(action: {
                    vm.resetGame()
                    dismiss()
                })
                
            }
            .opacity(opacity)
            .animation(.easeInOut(duration: 1), value: opacity)
        }
        .onAppear {
            opacity = 1
            SoundService.player.play(key: .lose)
        }
    }
    
    func PlayAgainBtn(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .fill(.green)
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding(80)
                .overlay {
                    Text("PLAY AGAIN")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                }
        }
    }
}

#Preview {
    EndGameView()
        .environmentObject(GameLogic())
}
