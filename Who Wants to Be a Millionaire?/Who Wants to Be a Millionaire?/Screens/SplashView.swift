//
//  SplashView.swift
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Background(image: BgImage.emptyBg)
            
            Image("Logo")
                .resizable()
                .scaledToFit()
                .padding(36)
        }
    }
}

#Preview {
    SplashView()
}
