//
//  GameView.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Victor on 25.02.2024.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject private var store = GameStore()
    @State private var scale = 1.0
    
    var body: some View {
        ZStack {
            Image(.emptyBackground)
                .resizable()
                .ignoresSafeArea()
            Group {
                switch store.state {
                case .list(let model):
                    QustionsListView(current: model.index, allAmount: model.allAmounts)
                case .blank:
                    VStack {
                        Image(.logo)
                            .scaleEffect(scale)
                            .animation(.easeInOut(duration: 2).repeatForever(), value: scale)
                        Text("Loading")
                            .font(.title)
                    }
                case .question(let model):
                    VStack {
                        Group {
                            HStack {
                                Image(.logo)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 85, height: 85)
                                Text(model.question)
                                    .frame(maxWidth: .infinity)
                            }
                            HStack {
                                Text("Вопрос \(model.index)")
                                Text("\(model.amount) RUB")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                        .padding(.init(top: 15, leading: 15, bottom: 15, trailing: 15))
                        
                        ScrollView {
                            VStack {
                                ForEach(model.answers) {
                                    answer in
                                    
                                    Button(
                                        action: {
                                            store.send(.selectAnswer(answer.value))
                                        },
                                        label: {
                                            HStack {
                                                Text(answer.letter)
                                                Text(answer.value)
                                                    .frame(maxWidth: .infinity)
                                            }
                                            .padding(EdgeInsets(top: 15, leading: 14, bottom: 15, trailing: 14))
                                            .background(
                                                store.selectedAnswer == answer.value ? Gradients.gold : Gradients.blue
                                            )
                                            .clipShape(.rect(cornerRadius: 16))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(.gray)
                                            )
                                        }
                                    )
                                    .disabled(!store.selectedAnswer.isEmpty)
                                    .padding(EdgeInsets(top: 15, leading: 42, bottom: 15, trailing: 42))
                                }
                            }
                        }
                        
                        Text("\(store.timeRemaining)")
                            .font(.system(size: 20, weight: .semibold))
                        
                        HStack {
                            ForEach(model.lifelines) {
                                lifeline in
                                Button(
                                    action: {
                                        store.send(.selectLifeline(lifeline.type))
                                    },
                                    label: {
                                        ZStack {
                                            Image(lifeline.type.image)
                                                .resizable()
                                                .scaledToFit()
                                            if !lifeline.available {
                                                Image(systemName: "xmark")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundStyle(.red)
                                            }
                                        }
                                    }
                                )
                                .disabled(!lifeline.available)
                            }
                        }
                        .frame(height: 85)
                        .padding(.horizontal)
                    }
                case .result(let model):
                    EndGameView(
                        questionIndex: model.questionIndex,
                        win: model.win,
                        prize: model.prize,
                        newGameClosure: {
                            store.send(.newGame)
                        }
                    )
                }
            }
            .foregroundStyle(.white)
        }
        .sheet(
            isPresented: $store.showVote,
            content: {
                GameVoteView(data: store.voteData)
            }
        )
        .onAppear {
            store.send(.newGame)
            scale = 1.2
        }
        .onDisappear {
            store.send(.close)
        }
    }
}

#Preview {
    GameView()
}

extension Color {
    static let blueLight = Color("Gradient/Answer/BlueLight", bundle: nil)
    static let blueDark = Color("Gradient/Answer/BlueDark", bundle: nil)
}
