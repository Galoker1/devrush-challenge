//
//  RegistrationView.swift
//

import SwiftUI

struct RegistrationView: View {
    
    @EnvironmentObject var vm: GameLogic
    @State var playerName: String = ""
    
    var body: some View {
        ZStack {
            Background(image: BgImage.money)
            CoinsView()
            
            VStack {
                Image("Logo")
                    .resizableToFit()
                    .frame(width: 250)
                
                Text("Введите свой никнейм")
                    .font(.title)
                    .padding()
                
                PlayerTF(text: $playerName)
                
                RegistrationBtn {
                    vm.isGame = true
                    vm.playerName = playerName
                }
                
                Spacer()
            }
        }
    }
    
    func RegistrationBtn(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("lightgreen"))
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding(80)
                .overlay {
                    Text("Регистрация")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                }
        }
    }
}

#Preview {
    RegistrationView()
}
