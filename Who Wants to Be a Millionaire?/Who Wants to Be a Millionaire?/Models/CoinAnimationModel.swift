//
//  CoinAnimation.swift
//

import SwiftUI
import Combine

final class CoinAnimationModel: ObservableObject {
    
    var avtodollars = [CoinAnimatableProperties]()
    var coins = [CoinAnimatableProperties]()
    
    func updateDolars () {
        for _ in 1...50 {
           coins.append(CoinAnimatableProperties(speed: .random(in: 10...30), angularSpeed: .random(in: 0.5...15), initialXOffset:.random(in: -170...170), initialYOffset: .random(in: -4500 ... -600), number: .random(in: 1...4), axisX: .random(in: 0...1), axisY: .random(in: 0...1), axisZ: .random(in: 0...1), saturation: .random(in: 0.8...1.2), hueRotation: .random(in: -15...15)))
        }
    }
}
  
