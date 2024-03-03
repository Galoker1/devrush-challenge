//
//  PlayerTF.swift
//

import SwiftUI

struct PlayerTF: View {
    
    @Binding var text: String
    @FocusState private var isFocused: Bool
    var fontSize: CGFloat = 27
    
    var body: some View {
        VStack {
            ZStack {
                Image("tfbg")
                    .resizableToFit()
                    .frame(height: 70)
            }
        }
        .overlay {
            VStack {
                if #available(iOS 16.0, *) {
                    TextField("", text: $text)
                        .scrollContentBackground(.hidden)
                        .font(.system(size: fontSize))
                        .focused($isFocused)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .autocorrectionDisabled()
                        .multilineTextAlignment(.center)
                } else {
                    TextField("", text: $text)
                        .font(.system(size: fontSize))
                        .focused($isFocused)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .autocorrectionDisabled()
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.top, 4)
        }
    }
}

#Preview {
    ZStack {
        Background(image: BgImage.money)
        PlayerTF(text: .constant(""))

    }
}

