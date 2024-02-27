//
//  GameView.swift
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var vm: GameLogic
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            if !vm.isGame {
                RegistrationView()
                    .environmentObject(vm)
            } else {
                QuestionView()
                    .environmentObject(vm)
            }
            
            if vm.showProgress {
                AllQuestionsView()
                    .environmentObject(vm)
            }
            
            if vm.endGame {
                EndGameView()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    GameView()
        .environmentObject(GameLogic())
}
