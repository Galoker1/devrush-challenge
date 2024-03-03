//
//  ResultsModel.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Егор  Хлямов on 28.02.2024.
//

import Foundation

struct Results: Codable {
    var resulsArray: [ResultsModel]
}
struct ResultsModel: Codable {
    var id: UUID
    var name: String
    var score: Int
}
