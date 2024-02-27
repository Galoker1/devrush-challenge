//
//  GameView.swift
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var vm: GameLogic
    
    
    var body: some View {
        ZStack {
            if !vm.isGame {
                RegistrationView()
                    .environmentObject(vm)
                    .transition(.slide)
                
            } else {
                QuestionView()
                    .environmentObject(vm)
                    .transition(.slide)
            }
            
            if vm.showProgress {
                AllQuestionsView()
                    .transition(.opacity)
                    .environmentObject(vm)
            }
            
            if vm.endGame {
                EndGameView()
                    .transition(.opacity)
            }
        }
        .overlay(alignment: .topTrailing) {
            DismissBtn()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    GameView()
        .environmentObject(GameLogic())
}
