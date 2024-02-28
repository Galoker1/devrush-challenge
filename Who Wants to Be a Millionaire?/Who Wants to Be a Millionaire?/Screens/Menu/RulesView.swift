//
//  RulesView.swift
//

import SwiftUI

struct RulesView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Background(image: BgImage.peoples)
            Text("Экран правил")
                .font(.largeTitle)
        }
        .overlay(alignment: .topTrailing) {
            DismissBtn()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    RulesView()
}
