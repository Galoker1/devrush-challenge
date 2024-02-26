//
//  RegistrationView.swift
//

import SwiftUI

struct RegistrationView: View {
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
                Spacer()
            }
        }
    }
}

#Preview {
    RegistrationView()
}
