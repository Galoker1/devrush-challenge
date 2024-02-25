//
//  QuestionsEntity.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Victor on 25.02.2024.
//

import Foundation

struct QuestionsEntity: Decodable {
    let responseCode: Int
    let results: [QuestionEntity]
}

struct QuestionEntity: Decodable, Identifiable {
    var id: String {
        type + question + correctAnswer
    }
    
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}
