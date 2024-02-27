//
//  QuestionView.swift
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var vm: GameLogic
    
    
    var body: some View {
        ZStack {
            Background(image: BgImage.empty)
            Button {
                vm.isGame = false
                vm.endGame = true
            } label: {
                Text("Завершить игру")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                    .background(Gradients.blue)
            }
        }
        .overlay(alignment: .topTrailing) {
            DismissBtn()
        }
    }
}

#Preview {
    QuestionView()
        .environmentObject(GameLogic())
}
