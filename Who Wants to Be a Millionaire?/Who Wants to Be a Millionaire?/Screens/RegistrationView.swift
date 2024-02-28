//
//  RegistrationView.swift
//

import SwiftUI

struct RegistrationView: View {
    
    @State var playerName: String = ""
    
    var body: some View {
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
                
                RegistrationBtn {
                    
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
                .overlay {
                    Text("Регистрация")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                }
        }
        .padding(40)
    }
}

#Preview {
    RegistrationView()
}
