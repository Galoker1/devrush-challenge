//
//  MenuView.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Егор  Хлямов on 25.02.2024.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                        Image("EmptyBackground")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped() // Обрезать изображение, чтобы оно не выходило за пределы экрана
                    }
                    .edgesIgnoringSafeArea(.all)
            VStack {
                Image("Logo")
                    .imageScale(.large)
                    .padding(.top, 40)
                Text("Добро пожаловать")
                    .font(.system(size: 24))
                    .foregroundColor(Color.white)
                Text("Кто хочет стать миллионером?")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color.white)
                Spacer()
                menuButton(text: "Начать игру", action: {})
                menuButton(text: "Результаты", action: {})
                menuButton(text: "Правила игры", action: {})
                Spacer()
            }
        }
    }
    
    func menuButton(text: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(Color.white)
                .background(
                    Image("BlueBox")
                )
        }
        .padding(.vertical)
    }
}

#Preview {
    MenuView()
}
