//
//  Background.swift
//

import SwiftUI

struct Background: View {
    
    let image: String
    
    var body: some View {
        ZStack {
            Image(image)
                .resizableToFill()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    Background(image: BgImage.peoples)
}
