//
//  QuestionView.swift
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var vm: GameLogic
    
    
    var body: some View {
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
}

#Preview {
    QuestionView()
        .environmentObject(GameLogic())
}
