//
//  EndGameView.swift
//

import SwiftUI

struct EndGameView: View {
    @Environment(\.dismiss) var dismiss
    let questionIndex: Int
    let win: Bool
    let prize: Int
    let newGameClosure: () -> Void
    let name: String
    @State var opacity: Double = 0
    
    var body: some View {
        NavigationView {
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
                    
                    playAgainBtn()
                    
                  
                    NavigationLink(destination: MenuView()) {
                        Text("MENU")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.green)
                                    .frame(height: 50)
                                    .frame(width: 200)
                            )
                            .padding(.top, 30)
                    }
                }
                .opacity(opacity)
                .animation(.easeInOut(duration: 1), value: opacity)
            }
            .onAppear {
                opacity = 1
                var results: Results? = UserDefaultService.shared.getStructs(forKey: "Result")
                if results == nil {
                    results = Results(resulsArray: [ResultsModel(id: UUID(), name: name, score: prize)])
                } else {
                    results?.resulsArray.append(ResultsModel(id: UUID(), name: name, score: prize))
                }
                UserDefaultService.shared.saveStructs(structs: results, forKey: "Result")
            }
            
        }
    }
    
    func playAgainBtn() -> some View {
        Button {
            newGameClosure()
        } label: {
            Text("PLAY AGAIN")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.green)
                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .frame(width: 300)
                )
  
        }
    }
}

#Preview {
    EndGameView(
        questionIndex: 10,
        win: false,
        prize: 1000,
        newGameClosure: {}, 
        name: "Egor"
    )
}
