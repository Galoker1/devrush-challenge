//
//  MenuView.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Егор  Хлямов on 25.02.2024.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView {
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
                    Image(.logo)
                        .imageScale(.large)
                        .padding(.top, 40)
                    Text("Добро пожаловать")
                        .font(.system(size: 24))
                        .foregroundColor(Color.white)
                    Text("Кто хочет стать миллионером?")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color.white)
                    Spacer()
                    NavigationLink(
                        destination: {
                            GameView()
                        },
                        label: {
                            MenuItem(title: "Начать игру")
                        }
                    )
                    NavigationLink(
                        destination: {
                            
                        },
                        label: {
                            MenuItem(title: "Правила игры")
                        }
                    )
                    NavigationLink(
                        destination: {
                            
                        },
                        label: {
                            MenuItem(title: "Результаты")
                        }
                    )
                    Spacer()
                }
            }
        }
    }
}

struct MenuItem: View {
    
    let title: String
    
    var body: some View {
        ZStack {
            Gradients.blue
            Text(title)
            .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
            .foregroundStyle(.white)
        }
        .clipShape(.rect(cornerRadius: 16))
        .frame(height: 40)
        .padding(.init(top: 10, leading: 35, bottom: 0, trailing: 35))
    }
}

#Preview {
    MenuView()
}
