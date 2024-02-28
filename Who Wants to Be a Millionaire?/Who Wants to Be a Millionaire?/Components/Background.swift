//
//  Background.swift
//

import SwiftUI

struct Background: View {
    
    let image: String
    
    var body: some View {
        
        GeometryReader { geometry in
            Image(image)
                .resizableToFill()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Background(image: BgImage.peoples)
}
