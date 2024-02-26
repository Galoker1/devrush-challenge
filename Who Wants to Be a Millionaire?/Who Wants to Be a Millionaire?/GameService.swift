//
//  GameService.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Victor on 25.02.2024.
//

import Foundation

final class GameService {
    
    @Published var currentRound: QuestionRoundModel?
    var result: ResultRoundModel {
        .init(status: questions.isEmpty ? .win : .lose, sum: questions.isEmpty ? 1_000_000 : saveAmount)
    }
    
    private var currentQuestion: QuestionEntity?
    private let networkService: NetworkServiceProtocol
    private var questions = [QuestionEntity]()
    private var availableLifelines: [LifelineModel.LifelineType] = [.fiftyOnFifty, .phoneFriend, .askAudience]
    
    private var index = 0
    private let letters = [
        0: "A",
        1: "B",
        2: "C",
        3: "D"
    ]
    private let amounts = [100, 200, 300, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 125000, 250000, 500000, 1000000]
    private var saveAmount: Int = .zero
    
    init(_ networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    @discardableResult
    func loadQuestions() async -> Bool {
        async let easyRequest = networkService.getQuestions(amount: 5, difficulty: .easy)
        async let medRequest = networkService.getQuestions(amount: 5, difficulty: .medium)
        async let hardRequest = networkService.getQuestions(amount: 5, difficulty: .hard)
        
        let response = await (easyRequest, medRequest, hardRequest)
        
        guard let easyQuestions = try? response.0.get(),
              let medQuestions = try? response.1.get(),
              let hardQuestions = try? response.2.get() else {
            return false
        }
        
        index = .zero
        saveAmount = .zero
        availableLifelines = [.fiftyOnFifty, .phoneFriend, .askAudience]
        questions = easyQuestions.results + medQuestions.results + hardQuestions.results
        return true
    }
    
    func nextQuestion() -> QuestionRoundModel? {
        guard !questions.isEmpty || index < amounts.count else {
            return nil
        }
        
        self.currentQuestion = questions.removeFirst()
        
        guard let currentQuestion else {
            return nil
        }
        
        currentRound = .init(
            question: currentQuestion.question,
            index: index + 1,
            amount: amounts[index],
            answers: ([currentQuestion.correctAnswer] + currentQuestion.incorrectAnswers).shuffled().enumerated().map {
                .init(letter: letters[$0.0] ?? "A", value: $0.1, isSelected: false)
            },
            lifelines: LifelineModel.LifelineType.allCases.map {
                .init(type: $0, available: availableLifelines.contains($0))
            }
        )
        return currentRound
    }
    
    func answer(_ value: String) -> Bool {
        if value == currentQuestion?.correctAnswer {
            if [1000, 32000].contains(amounts[index]) {
                saveAmount = amounts[index]
            }
            index += 1
            return true
        }
        return false
    }
    
    func selectLifeline(_ lifeline: LifelineModel.LifelineType) -> QuestionRoundModel? {
        guard let currentRound, let currentQuestion else {
            return nil
        }
        
        guard availableLifelines.contains(lifeline) else {
            return currentRound
        }
        availableLifelines.removeAll(where: { $0 == lifeline })
        
        var modRound = currentRound
        modRound.lifelines = LifelineModel.LifelineType.allCases.map {
            .init(type: $0, available: availableLifelines.contains($0))
        }
        
        switch lifeline {
        case .fiftyOnFifty:
            var answers = modRound.answers
            
            for incorrectAnswer in currentQuestion.incorrectAnswers[..<2] {
                answers.removeAll(where: { $0.value == incorrectAnswer })
            }
            modRound.answers = answers
        default:
            break
        }
        
        self.currentRound = modRound
        return modRound
    }
}
