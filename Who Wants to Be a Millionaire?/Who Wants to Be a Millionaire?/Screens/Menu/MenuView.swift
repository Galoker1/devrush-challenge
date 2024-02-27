//
//  MenuView.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Егор  Хлямов on 25.02.2024.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var vm: GameLogic
    
    var body: some View {
        NavigationView {
            ZStack {
                Background(image: BgImage.empty)
                
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
                    
                    NavigationLink {
                        GameView()
                            .environmentObject(vm)
                    } label: {
                        MenuButton(text: "Начать игру")
                    }
                    
                    NavigationLink {
                        ResultsView()
                            .environmentObject(vm)
                    } label: {
                        MenuButton(text: "Результаты")
                    }
                    
                    NavigationLink {
                        RulesView()
                            .environmentObject(vm)
                    } label: {
                        MenuButton(text: "Правила игры")
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationViewStyle(.stack)
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
        .environmentObject(GameLogic())
}
