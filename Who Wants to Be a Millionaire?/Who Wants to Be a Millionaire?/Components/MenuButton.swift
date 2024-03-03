//
//  MenuButton.swift
//

import SwiftUI

struct MenuButton: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(Color.white)
            .background(
                Image("BlueBox")
            )
            .padding(.vertical)
    }
}

#Preview {
    MenuButton(text: "Начать игру")
}
