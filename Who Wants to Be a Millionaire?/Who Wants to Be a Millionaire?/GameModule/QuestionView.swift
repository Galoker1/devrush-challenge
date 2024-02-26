//
//  QuestionView.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Victor Rubenko on 25.02.2024.
//

import SwiftUI

struct QuestionView: View {
    
    @ObservedObject private var store = GameStore()
    
    var body: some View {
        ZStack {
            Image(.frame)
                .resizable()
                .ignoresSafeArea()
            Group {
                switch store.state {
                case .blank:
                    Text("blank")
                case .question(let questionRoundModel):
                    VStack {
                        Group {
                            HStack {
                                Image(.logo)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 85, height: 85)
                                Text(questionRoundModel.question)
                                    .frame(maxWidth: .infinity)
                            }
                            HStack {
                                Text("Вопрос \(questionRoundModel.index)")
                                Text("\(questionRoundModel.amount) RUB")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                        .padding(.init(top: 15, leading: 15, bottom: 15, trailing: 15))
                        
                        ScrollView {
                            VStack {
                                ForEach(questionRoundModel.answers) {
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
                                                LinearGradient(
                                                    colors: [
                                                        Color.blueLight,
                                                        Color.blueDark,
                                                        Color.blueLight,
                                                    ],
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                )
                                            )
                                            .clipShape(.rect(cornerRadius: 16))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(.gray)
                                            )
                                        }
                                    )
                                    .padding(EdgeInsets(top: 15, leading: 42, bottom: 15, trailing: 42))
                                }
                            }
                        }
                        
                        HStack {
                            ForEach(questionRoundModel.lifelines) {
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
                case .result(let resultRoundModel):
                    GeometryReader {
                        geometry in
                        
                        VStack(alignment: .center) {
                            Image(.logo)
                                .resizable()
                                .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                                .scaledToFit()
                            switch resultRoundModel.status {
                            case .win:
                                Text("You win 1 000 000!")
                                    .font(.system(size: 24, weight: .medium))
                            case .lose:
                                Text("You losed")
                                    .font(.system(size: 24, weight: .medium))
                                if resultRoundModel.sum != .zero {
                                    Text("But get \(resultRoundModel.sum) RUB")
                                }
                                Spacer()
                                Button(
                                    action: {
                                        store.send(.newGame)
                                    },
                                    label: {
                                        Text("PLAY AGAIN")
                                            .font(.system(size: 32, weight: .medium))
                                            .padding(32)
                                            .background(.green)
                                            .clipShape(.rect(cornerRadius: 20))
                                    }
                                )
                                .padding(.init(top: .zero, leading: .zero, bottom: 84, trailing: .zero))
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
            }
            .foregroundStyle(.white)
        }
        .onAppear {
            store.send(.newGame)
        }
    }
}

#Preview {
    QuestionView()
}

extension Color {
    static let blueLight = Color("Gradient/Answer/BlueLight", bundle: nil)
    static let blueDark = Color("Gradient/Answer/BlueDark", bundle: nil)
}
