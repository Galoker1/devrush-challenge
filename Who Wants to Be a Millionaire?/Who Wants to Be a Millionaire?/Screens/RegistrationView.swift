//
//  RegistrationView.swift
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var playerName: String = ""
    @State private var isPresentedGameView = false
    var body: some View {
        NavigationView {
            ZStack {
                Background(image: BgImage.money)
                
                CoinsView()
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
                
                
                VStack {
                    Image("Logo")
                        .resizableToFit()
                        .frame(width: 250)
                    
                    Text("Введите свой никнейм")
                        .font(.title)
                        .padding()
                    
                    PlayerTF(text: $playerName)
                    
                    
                    NavigationLink(destination: GameView(name: playerName)) {
                        RegistrationBtn {
                            
                        }
                        
                    }
                    Spacer()
                }
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Image("x")
                        .padding(.trailing, 16)
                }
            }
            
        }
        .navigationBarHidden(true)
        
    }
    
    func RegistrationBtn(action: @escaping () -> Void) -> some View {

            RoundedRectangle(cornerRadius: 20)
                .fill(Color("lightgreen"))
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .overlay {
                    Text("Регистрация")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                }
        
        .padding(40)
    }
}

#Preview {
    RegistrationView()
}
