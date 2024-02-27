//
//  GameService.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Victor on 25.02.2024.
//

import Foundation

final class GameService {
    
    static let amounts = [100, 200, 300, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 125000, 250000, 500000, 1000000]
    
    @Published var currentRound: QuestionRoundModel?
    var result: ResultRoundModel {
        .init(win: questions.isEmpty, questionIndex: index, prize: questions.isEmpty ? 1_000_000 : saveAmount)
    }
    
    private var easyQuestions = [QuestionEntity]()
    private var medQuestions = [QuestionEntity]()
    private var hardQuestions = [QuestionEntity]()
    private var currentQuestion: QuestionEntity?
    private let networkService: NetworkServiceProtocol
    private var questions = [QuestionEntity]()
    private var availableLifelines: [LifelineModel.LifelineType] = [.fiftyOnFifty, .phoneFriend, .askAudience]
    private var canMistake = false
    
    private(set) var index = 0
    private let letters = [
        0: "A",
        1: "B",
        2: "C",
        3: "D"
    ]
    private var saveAmount: Int = .zero
    
    init(_ networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    @discardableResult
    func loadQuestions() async -> Bool {
        if [easyQuestions, medQuestions, hardQuestions].map({ $0.count > 5 }).contains(false) {
            async let easyRequest = networkService.getQuestions(amount: 50, difficulty: .easy, delay: 0)
            async let medRequest = networkService.getQuestions(amount: 50, difficulty: .medium, delay: 5)
            async let hardRequest = networkService.getQuestions(amount: 50, difficulty: .hard, delay: 10)
            
            let response = await (easyRequest, medRequest, hardRequest)
            
            guard let easyQuestions = try? response.0.get(),
                  let medQuestions = try? response.1.get(),
                  let hardQuestions = try? response.2.get() else {
                return false
            }
            
            self.easyQuestions = easyQuestions.results
            self.medQuestions = medQuestions.results
            self.hardQuestions = hardQuestions.results
        }
        
        canMistake = false
        index = .zero
        saveAmount = .zero
        availableLifelines = [.fiftyOnFifty, .phoneFriend, .askAudience]
        questions = Array(easyQuestions[0..<5]) + Array(medQuestions[0..<5]) + Array(hardQuestions[0..<5])
        
        easyQuestions.removeFirst(5)
        medQuestions.removeFirst(5)
        hardQuestions.removeFirst(5)
        
        return true
    }
    
    func nextQuestion() -> QuestionRoundModel? {
        guard !questions.isEmpty || index < Self.amounts.count else {
            return nil
        }
        
        self.currentQuestion = questions.removeFirst()
        
        guard let currentQuestion else {
            return nil
        }
        
        currentRound = .init(
            question: currentQuestion.fQuestion,
            index: index + 1,
            amount: Self.amounts[index],
            answers: ([currentQuestion.fCorrectAnswer] + currentQuestion.fIncorrectAnswers).shuffled().enumerated().map {
                .init(letter: letters[$0.0] ?? "A", value: $0.1, isSelected: false)
            },
            lifelines: LifelineModel.LifelineType.allCases.map {
                .init(type: $0, available: availableLifelines.contains($0))
            }
        )
        return currentRound
    }
    
    func answer(_ value: String) -> Bool {
        if value == currentQuestion?.fCorrectAnswer || canMistake {
            if [1000, 32000].contains(Self.amounts[index]) {
                saveAmount = Self.amounts[index]
            }
            index += 1
            canMistake = false
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
        case .phoneFriend:
            canMistake = true
        default:
            break
        }
        
        self.currentRound = modRound
        return modRound
    }
    
    func askAudience() -> [String: Double] {
        guard let currentRound, let currentQuestion else {
            return [:]
        }
        var showAnswer = [true, false]
        if index < 9 {
            showAnswer += [true, true]
        }
        
        var data = [String: Double]()
        
        if showAnswer.shuffled().randomElement() == true {
            var values = [0.1, 0.2, 0.2].shuffled()
            for answer in currentRound.answers {
                if answer.value == currentQuestion.correctAnswer {
                    data[answer.letter] = 0.5
                } else {
                    data[answer.letter] = values.popLast() ?? 0.1
                }
            }
        } else {
            var values = [0.1, 0.2, 0.5].shuffled()
            for answer in currentRound.answers {
                if answer.value == currentQuestion.correctAnswer {
                    data[answer.letter] = 0.2
                } else {
                    data[answer.letter] = values.popLast() ?? 0.1
                }
            }
        }
        
        return data
    }
}
