//
//  NetworkService.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Victor on 25.02.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case failedRequest
    case invalidResponse
}

enum QuestionDifficalty: String {
    case easy
    case medium
    case hard
}

protocol NetworkServiceProtocol {
    func getQuestions(amount: Int, difficulty: QuestionDifficalty, delay: Int) async -> Result<QuestionsEntity, NetworkError>
}

final actor NetworkService {
    
    private let session: URLSession
    
    init() {
        self.session = URLSession(configuration: .default)
    }
}

extension NetworkService: NetworkServiceProtocol {
    func getQuestions(amount: Int, difficulty: QuestionDifficalty, delay: Int) async -> Result<QuestionsEntity, NetworkError> {
        var urlComponents = URLComponents(string: Consts.baseURL)
        urlComponents?.queryItems = [
            .init(name: .amount, value: "\(amount)"),
            .init(name: .difficalty, value: difficulty.rawValue.capitalized)
        ]
        guard let url = urlComponents?.url else {
            return .failure(.invalidURL)
        }
        print(url)
        
        try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        
        guard let (data, _) = try? await session.data(from: url) else {
            return .failure(.failedRequest)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let decoded = try? decoder.decode(QuestionsEntity.self, from: data) else {
            return .failure(.invalidResponse)
        }
        
        return .success(decoded)
    }
}

private enum Consts {
    static let baseURL = "https://opentdb.com/api.php"
}

private extension String {
    static let amount = "amount"
    static let difficalty = "difficalty"
}
