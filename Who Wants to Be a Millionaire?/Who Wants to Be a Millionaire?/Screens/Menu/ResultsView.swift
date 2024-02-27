//
//  ResultsView.swift
//

import SwiftUI

struct ResultsView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Background(image: BgImage.peoples)
            Text("Экран результатов")
                .font(.largeTitle)
        }
        .overlay(alignment: .topTrailing) {
            DismissBtn()
        }
        .navigationBarHidden(true)
    }
    
}

#Preview {
    ResultsView()
}
