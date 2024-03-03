//
//  AllQuestionsViewModel.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Егор  Хлямов on 28.02.2024.
//

import Foundation

enum AllQuestionsViewModelState {
    case successAnswer
    case wrongAnswer
}
class AllQuestionsViewModel: ObservableObject {
    @Published var state: AllQuestionsViewModelState
    @Published var numberQuestion: Int
    
    init(state: AllQuestionsViewModelState, numberQuestion: Int) {
        self.state = state
        self.numberQuestion = numberQuestion
    }
}
