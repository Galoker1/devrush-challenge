//
//  GameLogic.swift
//

import SwiftUI

final class GameLogic: ObservableObject {
   
    @Published var isSplash = true
    
    var playerName = ""
    @Published var currentQuestion = 1
    @Published var helps = [true, true, true]  // доступные подсказки: 50:50, право на ошибку, зал
    @Published var isAllowToFail = false // флаг для состояния, когда используем право на ошибку, чтобы не завершать игру
    @Published var isGame = false // флаг для показа экрана вороса
    @Published var showProgress = false // флаг для показа экрана прогресса (включается на несколько секунд)
    @Published var endGame = false // анимация конца игры
    @Published var isMillion = false // конец игры в случае победы (можно обойтись и без этого флага, например трекая currentQuestion, но это удобно)
    
    
    func resetGame() {
        currentQuestion = 1
        helps = [true, true, true]
        isGame = false
        endGame = false
        isMillion = false
        playerName = ""
    }
}
