//
//  GameStore.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Victor on 26.02.2024.
//

import SwiftUI

struct QuestionRoundModel {
    let question: String
    let index: Int
    let amount: Int
    var answers: [AnswerModel]
    var lifelines: [LifelineModel]
    var blocked = false
    
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
    
    let win: Bool
    let questionIndex: Int
    let prize: Int
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

struct RoundListModel {
    let index: Int
    let allAmounts = GameService.amounts
}

enum GameState {
    case blank
    case question(QuestionRoundModel)
    case list(RoundListModel)
    case result(ResultRoundModel)
}

enum GameAction {
    case newGame
    case close
    case selectAnswer(String)
    case selectLifeline(_ type: LifelineModel.LifelineType)
}

final class GameStore: ObservableObject {
    @Published private(set) var state: GameState = .blank
    @Published private(set) var timeRemaining = 0
    @Published var showVote = false
    @Published private(set) var selectedAnswer = ""
    
    private(set) var voteData = [String: Double]()
    
    private var timer: Timer?
    private let gameService = GameService(NetworkServiceMock())
    
    func send(_ action: GameAction) {
        switch action {
        case .newGame:
            showVote = false
            state = .blank
            Task {
                @MainActor in
                
                guard await gameService.loadQuestions(), let nextQuestion = gameService.nextQuestion() else {
                    return
                }
                state = .question(nextQuestion)
                SoundService.shared.play(key: .think)
                startTimer()
            }
        case .close:
            timer?.invalidate()
            timer = nil
            SoundService.shared.stop()
        case .selectAnswer(let answer):
            selectedAnswer = answer
            timer?.invalidate()
            
            SoundService.shared.play(key: .intrigue)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                [weak self] in
                
                self?.selectedAnswer = ""
                
                guard let self else { return }
                
                guard gameService.answer(answer), let nextQuestion = gameService.nextQuestion() else {
                    state = .result(gameService.result)
                    if gameService.result.win {
                        SoundService.shared.play(key: .million)
                    } else {
                        SoundService.shared.play(key: .lose)
                    }
                    return
                }
                
                state = .list(.init(index: gameService.index))
                SoundService.shared.play(key: .win)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.state = .question(nextQuestion)
                    SoundService.shared.play(key: .think)
                    self.startTimer()
                }
            }

        case .selectLifeline(let lifeline):
            switch lifeline {
            case .askAudience:
                voteData = gameService.askAudience()
                showVote = true
                fallthrough
            default:
                guard let round = gameService.selectLifeline(lifeline) else {
                    return
                }
                state = .question(round)
            }
        }
    }
    
    private func startTimer() {
        timeRemaining = 30
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            [weak self] _ in
            
            self?.timerFired()
        }
    }
    
    private func timerFired() {
        timeRemaining -= 1
        
        if timeRemaining == .zero {
            timer?.invalidate()
            timer = nil
            state = .result(gameService.result)
        }
    }
}
