//
//  GameVoteView.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Victor on 27.02.2024.
//

import SwiftUI

struct GameVoteView: View {
    
    let data: [String: Double]
    
    private var barWidth: Double {
        (UIScreen.main.bounds.width - 100) / 4.0
    }
    private var barHeight: Double {
        barWidth * 3
    }
    private let colors: [Color] = [.blue, .green, .yellow, .red]
    
    var body: some View {
        ZStack {
            Image(.peoplesBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            HStack(alignment: .bottom) {
                ForEach(Array(zip(0..<data.count, data.keys.sorted(by: <))), id: \.0) {
                    index, key in
                    
                    VStack {
                        Rectangle()
                            .fill(colors[index])
                            .frame(width: barWidth, height: barHeight * (data[key] ?? 0))
                        Text(key)
                    }
                }
            }
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    GameVoteView(
        data: [
            "A": 0.1,
            "B": 0.2,
            "C": 0.5,
            "D": 0.2
        ]
    )
}
