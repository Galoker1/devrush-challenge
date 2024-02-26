//
//  GameStore.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Victor on 26.02.2024.
//

import SwiftUI

struct QuestionRoundModel: Identifiable {
    
    var id: String {
        question + answers.map { $0.value }.joined(separator: "") + lifelines.map { $0.type.rawValue }.joined(separator: "")
    }
    
    let question: String
    let index: Int
    let amount: Int
    var answers: [AnswerModel]
    var lifelines: [LifelineModel]
    
    struct AnswerModel: Identifiable {
        
        var id: String { value }
        let letter: String
        let value: String
        let isSelected: Bool
    }
}

struct ResultRoundModel {
    
    enum Status {
        case win
        case lose
    }
    
    let status: Status
    let sum: Int
}

struct LifelineModel: Identifiable {
    
    enum LifelineType: String, CaseIterable {
        case fiftyOnFifty
        case phoneFriend
        case askAudience
        
        var image: ImageResource {
            switch self {
            case .askAudience:
                    .helpPeople
            case .fiftyOnFifty:
                    .help50
            case .phoneFriend:
                    .helpCall
            }
        }
    }
    
    var id: String { type.rawValue }
    let type: LifelineType
    let available: Bool
}

enum GameState {
    case blank
    case question(QuestionRoundModel)
    case result(ResultRoundModel)
}

enum GameAction {
    case newGame
    case selectAnswer(String)
    case selectLifeline(_ type: LifelineModel.LifelineType)
}

final class GameStore: ObservableObject {
    @Published private(set) var state: GameState = .blank
    
    private let gameService = GameService(NetworkServiceMock())
    
    func send(_ action: GameAction) {
        switch action {
        case .newGame:
            state = .blank
            Task {
                @MainActor in
                
                guard await gameService.loadQuestions(), let nextQuestion = gameService.nextQuestion() else {
                    return
                }
                state = .question(nextQuestion)
            }
        case .selectAnswer(let answer):
            guard gameService.answer(answer), let nextQuestion = gameService.nextQuestion() else {
                state = .result(gameService.result)
                return
            }
            state = .question(nextQuestion)
        case .selectLifeline(let lifeline):
            guard let round = gameService.selectLifeline(lifeline) else {
                return
            }
            state = .question(round)
        }
    }
}
