//
//  EndGameView.swift
//

import SwiftUI

struct EndGameView: View {
    
    let questionIndex: Int
    let win: Bool
    let prize: Int
    let newGameClosure: () -> Void
    
    @State var opacity: Double = 0
    
    var body: some View {
        ZStack {
            Background(image: BgImage.empty)
            
            LightAnimation(color: .red)
            
            Text(win ? "WIN" : "LOSE")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .opacity(opacity)
                .animation(.easeInOut(duration: 1).delay(3), value: opacity)

            
            VStack {
                Image(.logo)
                    .resizableToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.6)
                
                Group {
                    if win {
                        Text("You won 1 million!")
                            .foregroundStyle(.yellow)
                    } else {
                        Text("You losed on \(questionIndex + 1) question\nSafe Haven: \(prize) RUB")
                    }
                }
                .foregroundStyle(.white)
                .padding(.top)
                .font(.title2)
                Spacer()
                
                PlayAgainBtn(action: {})
                
            }
            .opacity(opacity)
            .animation(.easeInOut(duration: 1), value: opacity)
        }
        .onAppear {
            opacity = 1
        }
    }
    
    func PlayAgainBtn(action: @escaping () -> Void) -> some View {
        Button {
            newGameClosure()
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
    EndGameView(
        questionIndex: 10,
        win: false,
        prize: 1000,
        newGameClosure: {}
    )
}
