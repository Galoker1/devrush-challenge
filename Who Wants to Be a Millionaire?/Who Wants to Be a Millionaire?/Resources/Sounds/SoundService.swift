//
//  SoundPlayer.swift
//

import Foundation
import AVFoundation

class SoundService {
    
    enum Sounds: String {
        case lose = "lose"
        case win = "win"
        case think = "thinking"
        case intrigue = "intrigue"
        case million = "millionwin"
    }

    
    static let shared = SoundService()

    private let player = AVPlayer(playerItem: nil)
    
    private init() {}
    
    func play(key: Sounds) {
        let url = Bundle.main.url(forResource: key.rawValue, withExtension: "mp3")
        
        guard let url else {
            return
        }
        player.replaceCurrentItem(with: .init(url: url))
        player.play()
    }
    
    func stop() {
        player.pause()
    }
}
