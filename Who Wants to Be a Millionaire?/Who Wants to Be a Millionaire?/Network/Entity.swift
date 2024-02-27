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
    
    var fQuestion: String {
        question.fromHTML()
    }
    
    var fCorrectAnswer: String {
        correctAnswer.fromHTML()
    }
    
    var fIncorrectAnswers: [String] {
        incorrectAnswers.map { $0.fromHTML() }
    }
}

private extension String {
    func fromHTML() -> String {
        guard let data = data(using: .utf8) else {
            return ""
        }
        
        guard let aString = try? NSMutableAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        ) else {
            return ""
        }
        return aString.string
    }
}
